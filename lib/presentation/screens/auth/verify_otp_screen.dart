import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:audaxious/domain/enums/button_state.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/viewmodels/auth/verify_otp_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_text_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:toastification/toastification.dart';

import '../../../core/routes/app_router.dart';
import '../../widgets/custom_toast.dart';

@RoutePage()
class VerifyOTPScreen extends HookConsumerWidget {
  String email;
  bool usernameExist;
  String username;
  VerifyOTPScreen({
    super.key,
    required this.email,
    required this.usernameExist,
    required this.username,
  });

  final pinController = TextEditingController();
  // late CountdownTimer _countdownTimer;
  // String _formattedTime = "";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reader = ref.read(VerifyOTPViewModel.notifier.notifier);
    final notifier = ref.watch(VerifyOTPViewModel.notifier);
    // final showResendButton = useState(false);
    print("Email $email and Username: $usernameExist");

    // _countdownTimer = CountdownTimer(duration: 120);
    // _countdownTimer.startCountdown((formattedTime) {
    //   _formattedTime = formattedTime;
    //   if (_countdownTimer.formatCountdown() == '00:00') {
    //     showResendButton.value = true;
    //   }
    // });

    final defaultPinTheme = PinTheme(
        width: 55,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        textStyle: Theme.of(context).textTheme.displayLarge,
        decoration: BoxDecoration(
            color: cardColor,
            border: Border.all(color: cardBorderColor, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(5))
        )
    );
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/audaxious_name_logo.png", width: 100, height: 16),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Image.asset("assets/images/audaxious_name_logo.png", width: 100, height: 16),
            //   ],
            // ),
            const Gap(150),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter OTP",
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
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Enter the OTP sent to the following email to sign-In ',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: greyTextColor),
                        children: <TextSpan>[
                          TextSpan(
                            text: email,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
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
                bool isVerifyOTPSuccessful = await reader.verifyOTP(email, pin);
                if (isVerifyOTPSuccessful) {
                  print("message ${notifier.message}");
                  print(notifier.user?.username);

                  CustomToast.show(
                    context: context,
                    title: "Success",
                    description: notifier.message,
                    type: ToastificationType.success,
                  );

                  if (usernameExist) {
                    print("User name exists $usernameExist");
                    context.router.replaceAll([const BottomBarRoute()]);
                  }else {
                    print("User name exists does not $usernameExist");
                    context.router.navigate(CreateUsernameRoute());
                  }
                }else {
                  CustomToast.show(
                    context: context,
                    title: "Error",
                    description: notifier.error,
                    type: ToastificationType.error,
                  );
                }
              }
            ),
            const Gap(40),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Visibility(
            //       visible: showResendButton.value,
            //       child: TextButton(
            //           onPressed: () async{
            //             showResendButton.value = false;
            //             _countdownTimer = CountdownTimer(duration: 120);
            //             _countdownTimer.startCountdown((formattedTime) {
            //               _formattedTime = formattedTime;
            //               if (_countdownTimer.formatCountdown() == '00:00') {
            //                 showResendButton.value = true;
            //               }
            //             });
            //
            //           },
            //           child: Text(
            //             "Resend",
            //             style: Theme.of(context).textTheme.displaySmall?.copyWith(color: secondaryColor, fontSize: 16),
            //           )
            //       ),
            //     ),
            //     Text(
            //       _formattedTime,
            //       style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 16),
            //     )
            //   ],
            // ),
            const Gap(50),
            PrimaryTextButton(
              onPressed: () {
                context.popRoute();
              },
              buttonText: "Change email",
              buttonState: notifier.viewState.isLoading
                  ? ButtonState.loading
                  :ButtonState.active,
              textColor: secondaryColor,
            ),

            // PrimaryButton(
            //   onPressed: () {
            //     context.popRoute();
            //   },
            //   buttonText: "Change email",
            //   buttonState: notifier.viewState.isLoading
            //       ? ButtonState.loading
            //       :ButtonState.active,
            // ),
          ],
        ),
      ),

    );
  }
}
