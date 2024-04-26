import 'package:audaxious/core/routes/app_router.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/viewmodels/auth/create_username_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

import '../../../core/utils/app_utils.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../../core/utils/view_utils.dart';
import '../../../domain/enums/button_state.dart';
import '../../widgets/alerts/custom_toast.dart';

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
      appBar: AppBar(
        title: Image.asset("assets/images/audaxious_name_logo.png", width: 100, height: 16),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(40),
              Image.asset("assets/images/user_octagon.png", width: 100, height: 100),
              const Gap(40),
              Text(
                "Create username",
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const Gap(30),
              Text(
                "To Build communities, Market Products, Earn rewards and Engage in Campaigns, Create a username",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: greyTextColor),
                textAlign: TextAlign.center,
              ),
              const Gap(20),
              TextFormField(
                controller: _usernameController,
                decoration: primaryTextFormFieldDecoration(labelText: 'Enter user name'),
                validator: requiredValidator,
                onChanged: (_) {
                  isFormValidated.value = formKey.currentState?.validate() ?? false;
                },
              ),
              const Gap(50),
              PrimaryButton(
                onPressed: () async {
                  bool isCreateUsernameSuccessful =
                      await reader.createUsername(context, _usernameController.text);
                  if (isCreateUsernameSuccessful) {
                    if (!context.mounted) return;
                    CustomToast.show(
                      context: context,
                      title: "Success",
                      description: "Username created successfully",
                      type: ToastificationType.success,
                    );
                    context.router.replaceAll([const BottomBarRoute()]);
                  }
                },
                buttonText: "Create username",
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
