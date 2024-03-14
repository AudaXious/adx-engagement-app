import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:audaxious/domain/enums/button_state.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/viewmodels/auth/verify_otp_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_button.dart';
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
  VerifyOTPScreen({super.key, required this.email});

  final pinController = TextEditingController();
  // late CountdownTimer _countdownTimer;
  // String _formattedTime = "";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reader = ref.read(VerifyOTPViewModel.notifier.notifier);
    final notifier = ref.watch(VerifyOTPViewModel.notifier);
    // final showResendButton = useState(false);

    // _countdownTimer = CountdownTimer(duration: 120);
    // _countdownTimer.startCountdown((formattedTime) {
    //   _formattedTime = formattedTime;
    //   if (_countdownTimer.formatCountdown() == '00:00') {
    //     showResendButton.value = true;
    //   }
    // });

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
                    "Enter the verification code sent to $email",
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

                  if (notifier.user?.username == null) {
                    context.router.navigate(SetUsernameRoute());
                  }else {
                    context.router.replaceAll([const BottomBarRoute()]);
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
            PrimaryButton(
              onPressed: () {
                context.popRoute();
              },
              buttonText: "Change email",
              buttonState: notifier.viewState.isLoading
                  ? ButtonState.loading
                  :ButtonState.active,
            ),
          ],
        ),
      ),

    );
  }
}
