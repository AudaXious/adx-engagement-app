import 'package:audaxious/presentation/widgets/buttons/primary_button.dart';
import 'package:audaxious/presentation/widgets/buttons/secondary_button.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/utils/view_utils.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            TextField(
              decoration: primaryTextFormFieldDecoration(labelText: 'Enter email address'),
            ),
            const Gap(50),
            SecondaryButton(
              onPressed: () {},
              buttonText: "Sign In"
            )

          ],
        ),
      ),
    );
  }
}
