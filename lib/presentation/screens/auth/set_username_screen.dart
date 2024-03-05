import 'package:audaxious/core/routes/app_router.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_button.dart';
import 'package:audaxious/presentation/widgets/buttons/secondary_button.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/utils/view_utils.dart';

@RoutePage()
class SetUsernameScreen extends StatelessWidget {
  SetUsernameScreen({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(50),
            Text(
              "Create username",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const Gap(5),
            Text(
              "Create username to Build communities, Market Products, Earn rewards",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Gap(20),
            Text(
              "Username",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(3),
            TextField(
              controller: _emailController,
              decoration: primaryTextFormFieldDecoration(labelText: 'Enter user name'),
            ),
            const Gap(50),
            SecondaryButton(
                onPressed: () {
                  context.router.replaceAll([const BottomBarRoute()]);
                },
                buttonText: "Set username"
            )

          ],
        ),
      ),
    );
  }
}
