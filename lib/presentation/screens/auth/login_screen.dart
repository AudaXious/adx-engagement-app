import 'package:audaxious/core/routes/app_router.dart';
import 'package:audaxious/domain/enums/button_state.dart';
import 'package:audaxious/presentation/viewmodels/auth/login_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/secondary_button.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/utils/view_utils.dart';

@RoutePage()

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends ConsumerState<LoginScreen> {
  late LoginViewModel provider;
  bool isFormValidated = false;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  void _validateForm() {
    setState(() {
      isFormValidated = loginFormKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = ref.watch(loginViewModelProvider);

    return Scaffold(
      body: Form(
        key: loginFormKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/pink_star.png", height: 20, width: 20),
                  Image.asset("assets/images/telegram.png", height: 20, width: 20),
                ],
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/audaxious_name_logo.png", width: 120, height: 20),
                ],
              ),
              const Gap(50),
              Text(
                "Sign In",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const Gap(5),
              Text(
                "Multisend, Build communities, Market Products, Earn rewards",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Gap(20),
              Text(
                "Email address",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Gap(3),
              TextFormField(
                controller: provider.emailCtr,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                decoration: primaryTextFormFieldDecoration(labelText: 'Email'),
                validator: emailValidator,
                onChanged: (_) => _validateForm(),
              ),
              const Gap(50),
              SecondaryButton(
                buttonText: "Sign in",
                onPressed: () async {
                  if (isFormValidated) {
                    await provider.loginUser(context);
                    if (provider.isSuccessful && provider.user != null) {
                      context.router.navigate(OTPRoute(email: provider.emailCtr.text));
                    }
                  }
                },
                buttonState: provider.isLoading
                    ? ButtonState.loading
                    : (isFormValidated)
                    ? ButtonState.active
                    : ButtonState.disabled,
              ),


            ],
          ),
        ),
      ),
    );
  }
}
