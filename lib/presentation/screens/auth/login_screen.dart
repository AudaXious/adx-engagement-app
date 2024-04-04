import 'package:audaxious/core/routes/app_router.dart';
import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:audaxious/domain/enums/button_state.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/viewmodels/auth/login_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

import '../../../core/utils/app_utils.dart';
import '../../../core/utils/view_utils.dart';
import '../../widgets/alerts/custom_toast.dart';

@RoutePage()
class LoginScreen extends HookConsumerWidget {
  LoginScreen({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reader = ref.read(LoginViewModel.notifier.notifier);
    final notifier = ref.watch(LoginViewModel.notifier);
    final isFormValidated = useState(false);

    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 43),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/audaxious_name_logo.png", width: 100, height: 16),
                ],
              ),
              const Gap(150),
              Text(
                "Sign In",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const Gap(30),
              Text(
                "Create or Login account to Multisend, Build communities, Market Products, Earn rewards",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: greyTextColor),
                textAlign: TextAlign.center,
              ),
              const Gap(20),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: primaryTextFormFieldDecoration(labelText: 'Enter email address'),
                validator: emailValidator,
                onChanged: (_) {
                  isFormValidated.value = formKey.currentState?.validate() ?? false;
                },
              ),
              const Gap(50),
              PrimaryButton(
                onPressed: () async {
                  bool isLoginSuccessful = await reader.loginUser(_emailController.text);
                  if (isLoginSuccessful) {
                    if (!context.mounted) return;
                    context.router.navigate(VerifyOTPRoute(
                      email: _emailController.text,
                    ));
                  }else {
                    if (!context.mounted) return;
                    CustomToast.show(
                      context: context,
                      title: "Error",
                      description: notifier.error,
                      type: ToastificationType.error,
                    );
                  }
                },
                buttonText: "Sign In",
                buttonState: notifier.viewState.isLoading
                    ? ButtonState.loading
                    : isFormValidated.value
                    ? ButtonState.active
                    : ButtonState.disabled,

              )
            ],
          ),
        ),
      ),
    );
  }
}
