import 'package:audaxious/domain/enums/button_state.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/domain/models/space.dart';
import 'package:audaxious/presentation/widgets/alerts/custom_toast.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_outline_button.dart';
import 'package:audaxious/presentation/widgets/progressBars/circular_progress_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

import '../../../core/routes/app_router.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../viewmodels/spaces/spaces_viewmodel.dart';
class SpaceCard extends HookConsumerWidget {
  Space space;
  SpaceCard({super.key, required this.space});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reader = ref.read(SpacesViewModel.notifier.notifier);
    final notifier = ref.watch(SpacesViewModel.notifier);
    final joinLoadingState = useState(false);

    return InkWell(
      splashColor: const Color(0x0d021418),
      onTap: () {
        context.router.navigate(SpaceDetailRoute(spaceId: space.uuid ?? "", space: space));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(width: 0.6, color: cardBorderColor),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: spacesCardColor
        ),
        child: Column(
          children: [
            const Gap(20),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipOval(
                              child: space.profileURL == null
                                  ? Image.asset(
                                      "assets/images/dumm_profile.png",
                                      width: cardProfileWidth,
                                      height: cardProfileHeight,
                                  )
                                  : CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: space.profileURL ?? "",
                                      placeholder: (context, url) => CircularProgressBar(),
                                      width: cardProfileWidth,
                                      height: cardProfileHeight,
                              ),
                            ),
                            const Gap(8),
                            Expanded(
                              child: Text(
                                space.title ?? "",
                                style: Theme.of(context).textTheme.displaySmall?.
                                copyWith(fontSize: 16, color: cardTitleColor),
                              ),
                            ),
                            const Gap(20),
                            SizedBox(
                              width: 90,
                              height: 30,
                              child: PrimaryOutlineButton(
                                onPressed: joinLoadingState.value
                                    ? null
                                    : () async {
                                  joinLoadingState.value = true;
                                  bool isSuccessful = await reader.joinSpace(space.uuid ?? "");

                                  if (isSuccessful) {
                                    if (!context.mounted) return;
                                    CustomToast.show(
                                      context: context,
                                      title: "Success",
                                      description: notifier.message,
                                      type: ToastificationType.success,
                                    );
                                  } else {
                                    if (!context.mounted) return;
                                    CustomToast.show(
                                      context: context,
                                      title: "Error",
                                      description: notifier.error,
                                      type: ToastificationType.error,
                                    );
                                  }
                                  joinLoadingState.value = false;
                                },

                                buttonText: "Join",
                                borderColor: secondaryColor.withOpacity(0.3),
                                buttonState: joinLoadingState.value
                                    ? ButtonState.loading
                                    : ButtonState.active,

                              ),
                            ),

                          ],
                        ),
                        const Gap(15),
                        Text(
                            shortenString(
                                space.description ?? "",
                                80
                            ),
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: greyTextColor)
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(width: 0.2, color: secondaryColor.withOpacity(0.6)),
                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                // color: lightTeal.withOpacity(0.2),
                              ),
                              child: Row(
                                children: [
                                  Image.asset("assets/images/user_group.png", width: 20, height: 20,),
                                  const Gap(5),
                                  Text(
                                    space.spaceMembersCount.toString(),
                                    style: Theme.of(context).textTheme.bodyMedium?.
                                    copyWith(color: secondaryColor.withOpacity(0.9)),
                                  ),

                                ],
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset("assets/images/internet.png", width: 17, height: 17,),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset("assets/images/twitter.png", width: 20, height: 20,),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset("assets/images/discord.png", width: 20, height: 20,),
                            ),

                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
