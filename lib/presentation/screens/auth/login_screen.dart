import 'package:audaxious/core/routes/app_router.dart';
import 'package:audaxious/domain/enums/button_state.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/viewmodels/auth/login_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/secondary_button.dart';
import 'package:audaxious/presentation/widgets/custom_toast.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

import '../../../core/utils/view_utils.dart';

@RoutePage()
class LoginScreen extends HookConsumerWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reader = ref.read(LoginViewModel.notifier.notifier);
    final notifier = ref.watch(LoginViewModel.notifier);

    return Scaffold(
      body: SingleChildScrollView(
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
            TextField(
              controller: _emailController,
              decoration: primaryTextFormFieldDecoration(labelText: 'Enter email address'),
            ),
            const Gap(50),
            SecondaryButton(
              onPressed: () async {
                await reader.loginUser(_emailController.text);
                if (notifier.viewState.isError) {
                  CustomToast.show(
                      context: context,
                      title: "Error",
                      description: notifier.error,
                      type: ToastificationType.error,
                  );
                }else {
                  if (notifier.user?.email != null) {
                    context.router.navigate(OTPRoute(email: notifier.user!.email!));
                  }
                }
              },
              buttonText: "Sign In",
              buttonState: notifier.viewState.isLoading
                  ? ButtonState.loading
                  : ButtonState.active,
            )

          ],
        ),
      ),
    );
  }
}
