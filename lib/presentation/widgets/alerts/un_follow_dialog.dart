
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/viewmodels/auth/login_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import '../../viewmodels/account/account_viewmodel.dart';
import '../buttons/primary_outline_button.dart';
import '../buttons/primary_text_button.dart';
import '../buttons/secondary_button.dart';
import 'custom_toast.dart';

class UnFollowDialog extends HookConsumerWidget {
  UnFollowDialog({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(AccountViewModel.notifier);
    final reader = ref.read(AccountViewModel.notifier.notifier);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
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
                    "Unfollow",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const Gap(10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Sorry to see you go, but there are plenty of other fun Spaces waiting for you!",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: greyTextColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Gap(30),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          height: 45,
                          child: PrimaryOutlineButton(
                            borderRadius: 10,
                            borderColor: secondaryColor.withOpacity(0.4),
                            buttonText: "Cancel",
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            buttonState: notifier.logoutViewState.isLoading
                                ? ButtonState.loading
                                : ButtonState.active,
                          ),
                        ),
                      ),
                      const Gap(5),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          height: 45,
                          child: SecondaryButton(
                            buttonText: "Confirm",
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                ],
              ),
            ),
        ),
        ),
      );
  }

}
