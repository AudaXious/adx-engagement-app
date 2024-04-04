import 'package:audaxious/core/routes/app_router.dart';
import 'package:audaxious/domain/enums/button_state.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/viewmodels/account/account_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_button.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/alerts/empty_result_found_illustration.dart';

@RoutePage()
class AccountScreen extends HookConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reader = ref.read(AccountViewModel.notifier.notifier);
    final notifier = ref.watch(AccountViewModel.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: PrimaryButton(
            buttonText: "Logout",
            onPressed: () async {
              bool isSuccessful = await reader.logoutUser();
              if (isSuccessful) {
                if (!context.mounted) return;
                context.router.replaceAll([LoginRoute()]);
              }
            },
            buttonState: notifier.logoutViewState.isLoading
                ? ButtonState.loading
                : ButtonState.active,
          ),
        ),
      )
    );
  }
}
