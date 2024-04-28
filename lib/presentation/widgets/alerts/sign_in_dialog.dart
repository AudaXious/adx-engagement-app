
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/viewmodels/auth/login_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/routes/app_router.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../../core/utils/view_utils.dart';
import '../../../domain/enums/button_state.dart';
import '../buttons/secondary_button.dart';
import 'custom_toast.dart';

class SignInDialog extends HookConsumerWidget {
  SignInDialog({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(LoginViewModel.notifier);
    final reader = ref.read(LoginViewModel.notifier.notifier);
    final isFormValidated = useState(false);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            // padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                border: Border.all(width: 0.6, color: cardBorderColor),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: spacesCardColor
            ),
            // height: size.height * 0.5,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        iconSize: 20,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close)
                      )
                    ],
                  ),
                  Text(
                    "Sign In",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const Gap(30),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: primaryTextFormFieldDecoration(labelText: 'Enter email address'),
                      validator: emailValidator,
                      onChanged: (_) {
                        isFormValidated.value = formKey.currentState?.validate() ?? false;
                      },
                    ),
                  ),
                  const Gap(20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    height: 45,
                    child: PrimaryButton(
                      buttonText: "Sign In with Email",
                      onPressed: () async {
                        bool isLoginSuccessful = await reader.loginUser(_emailController.text, context);
                        if (isLoginSuccessful) {
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                          context.router.navigate(VerifyOTPRoute(
                            email: _emailController.text,
                          ));
                        }
                      },
                      buttonState: notifier.viewState.isLoading
                          ? ButtonState.loading
                          : isFormValidated.value
                          ? ButtonState.active
                          : ButtonState.disabled,
                    ),
                  ),
                  const Gap(20),
                  const Text("Or"),
                  const Gap(20),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 45,
                      child: SecondaryButton(
                        buttonText: "Sign in with Google",
                        icon: "assets/images/google.png",
                        onPressed: () {
                        },
                      )
                  ),
                  const Gap(20),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 45,
                      child: SecondaryButton(
                        buttonText: "Sign in with WalletConnect",
                        icon: "assets/images/wallet_connect.png",
                        onPressed: () {
                        },
                      )
                  ),
                  const Gap(40),

                ],
              ),
            ),
        ),
        ),
      );
  }

}
