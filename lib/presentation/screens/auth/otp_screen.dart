import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:audaxious/domain/enums/button_state.dart';
import 'package:audaxious/presentation/viewmodels/auth/verify_otp_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';

import '../../../core/routes/app_router.dart';
import '../../../core/utils/countdown_timer.dart';



@RoutePage()

class OTPScreen extends ConsumerStatefulWidget {
  String email;
  OTPScreen({super.key, required this.email});

  @override
  ConsumerState<OTPScreen> createState() => _OTPScreen();
}
class _OTPScreen extends ConsumerState<OTPScreen> {
  late VerifyOTPViewModel provider;
  final pinController = TextEditingController();
  late CountdownTimer _countdownTimer;
  String _formattedTime = "";
  bool _showResendButton = false;

  @override
  void initState() {
    super.initState();
    _countdownTimer = CountdownTimer(duration: 120);
    _countdownTimer.startCountdown((formattedTime) {
      setState(() {
        _formattedTime = formattedTime;
        if (_countdownTimer.formatCountdown() == '00:00') {
          _showResendButton = true;
        }
      });
    });
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    provider = ref.watch(verifyOTPViewModelProvider);

    final defaultPinTheme = PinTheme(
        width: 53,
        height: 46,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        textStyle: Theme.of(context).textTheme.displayLarge,
        decoration: BoxDecoration(
            color: cardColor,
            border: Border.all(color: cardBorderColor, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(5))
        )
    );
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Verify email",
                  style: Theme.of(context).textTheme.displayLarge,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            const Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Enter the verification code sent to ${widget.email}",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const Gap(30),
            Pinput(
              controller: pinController,
              length: 6,
              autofocus: true,
              defaultPinTheme: defaultPinTheme,
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!
                  .copyWith(
                    color: Colors.transparent
                  )
              ),
              onCompleted: (pin) async {
                await provider.verifyOTPForSignIn(context, widget.email, pin);
                if (provider.isSuccessful) {
                  if (provider.username == null) {
                    print("Username doesn't exists");
                    context.router.navigate(SetUsernameRoute());
                  }else {
                    print("Username exists");
                    context.router.replaceAll([const BottomBarRoute()]);
                  }
                }
              }
            ),
            const Gap(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: _showResendButton,
                  child: TextButton(
                      onPressed: () async{
                        setState(() {
                          _showResendButton = false; // Hide the button
                        });

                        _countdownTimer = CountdownTimer(duration: 120);
                        _countdownTimer.startCountdown((formattedTime) {
                          setState(() {
                            _formattedTime = formattedTime;
                            if (_countdownTimer.formatCountdown() ==
                                '00:00') {
                              _showResendButton = true; // Show the button when the timer reaches zero
                            }
                          });
                        });

                      },
                      child: Text(
                        "Resend",
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(color: secondaryColor, fontSize: 16),
                      )
                  ),
                ),
                Text(
                  _formattedTime,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 16),
                )
              ],
            ),
            const Gap(50),
            PrimaryButton(
              onPressed: () {
                context.popRoute();
              },
              buttonText: "Change email",
              buttonState: provider.isLoading
                  ? ButtonState.loading
                  :ButtonState.active,
            ),
          ],
        ),
      ),

    );
  }
}
