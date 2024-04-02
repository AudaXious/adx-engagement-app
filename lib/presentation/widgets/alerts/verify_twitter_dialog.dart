import 'package:audaxious/core/utils/app_layout.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utils/app_utils.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../../core/utils/view_utils.dart';

class VerifyTwitterDialog extends HookConsumerWidget {
  VerifyTwitterDialog({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _tweetLinkController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = AppLayout.getSize(context);
    final isFormValidated = useState(false);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Form(
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
                Image.asset("assets/images/connect.png", width: 60, height: 60),
                const Gap(20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                      "Twitter verification",
                      style: Theme.of(context).textTheme.displayLarge
                          ?.copyWith(fontSize: 26)
                  ),
                ),
                const Gap(10),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "In order to continue, you need to verify your twitter account",
                    style: Theme.of(context).textTheme.bodyLarge
                        ?.copyWith(color: fadedTextColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Gap(30),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: cardBorderColor,
                              thickness: 1,
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    const Text("1"),
                    const Gap(10),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: cardBorderColor,
                              thickness: 1,
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 45,
                  child: PrimaryButton(
                    buttonText: "Tweet authentication post",
                    onPressed: () {},

                  ),
                ),
                const Gap(20),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: cardBorderColor,
                              thickness: 1,
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    const Text("2"),
                    const Gap(10),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: cardBorderColor,
                              thickness: 1,
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Gap(16),
                    Text(
                      "Tweet link",
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                const Gap(4),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: _tweetLinkController,
                    decoration: primaryTextFormFieldDecoration(labelText: 'Copy and paste the link to the tweet'),
                    validator: requiredValidator,
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
                    buttonText: "Verify twitter account",
                    onPressed: () {},

                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      );
  }
}
