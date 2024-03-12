import 'package:audaxious/core/routes/app_router.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/viewmodels/auth/create_username_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/secondary_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utils/app_utils.dart';
import '../../../core/utils/view_utils.dart';
import '../../../domain/enums/button_state.dart';

@RoutePage()
class CreateUsernameScreen extends HookConsumerWidget {
  CreateUsernameScreen({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reader = ref.read(CreateUsernameViewModel.notifier.notifier);
    final notifier = ref.watch(CreateUsernameViewModel.notifier);
    final isFormValidated = useState(false);

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
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
              TextFormField(
                controller: _usernameController,
                decoration: primaryTextFormFieldDecoration(labelText: 'Enter user name'),
                validator: requiredValidator,
                onChanged: (_) {
                  isFormValidated.value = formKey.currentState?.validate() ?? false;
                },
              ),
              const Gap(50),
              SecondaryButton(
                onPressed: () async {
                  await reader.createUsername(context, _usernameController.text);
                  if (!notifier.viewState.isError) {
                    context.router.replaceAll([const BottomBarRoute()]);
                  }
                },
                buttonText: "Set username",
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
