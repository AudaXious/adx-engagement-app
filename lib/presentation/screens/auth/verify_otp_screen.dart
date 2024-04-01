import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:audaxious/domain/enums/button_state.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/domain/models/user.dart';
import 'package:audaxious/presentation/viewmodels/auth/verify_otp_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_text_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:toastification/toastification.dart';

import '../../../core/routes/app_router.dart';
import '../../widgets/alerts/custom_toast.dart';

@RoutePage()
class VerifyOTPScreen extends HookConsumerWidget {
  String email;
  VerifyOTPScreen({
    super.key,
    required this.email,
  });

  final pinController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reader = ref.read(VerifyOTPViewModel.notifier.notifier);
    final notifier = ref.watch(VerifyOTPViewModel.notifier);

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
                final user = await reader.verifyOTP(email, pin);
                if (user == null) {
                  CustomToast.show(
                    context: context,
                    title: "Error",
                    description: notifier.error,
                    type: ToastificationType.error,
                  );

                }else {
                  CustomToast.show(
                    context: context,
                    title: "Success",
                    description: notifier.message,
                    type: ToastificationType.success,
                  );

                  if (user.username == null) {
                    print("User name does not exists ${user.username}");
                    context.router.navigate(CreateUsernameRoute());
                  }else {
                    print("User name exists ${user.username}");
                    context.router.replaceAll([const BottomBarRoute()]);
                  }
                }
              }
            ),
            const Gap(40),
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
          ],
        ),
      ),

    );
  }
}
