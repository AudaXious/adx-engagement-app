import 'package:audaxious/domain/enums/button_state.dart';
import 'package:audaxious/domain/models/space.dart';
import 'package:audaxious/presentation/widgets/alerts/custom_toast.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_outline_button.dart';
import 'package:audaxious/presentation/widgets/progressBars/circular_progress_bar.dart';
import 'package:audaxious/presentation/widgets/vertical_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

import '../../../core/routes/app_router.dart';
import '../../../core/services/shared_preferences_services.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../viewmodels/spaces/spaces_viewmodel.dart';
import '../alerts/sign_in_dialog.dart';
import '../card_space_tag.dart';
import '../space_tag.dart';
class SpaceCard extends HookConsumerWidget {
  Space space;
  SpaceCard({super.key, required this.space});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reader = ref.read(SpacesViewModel.notifier.notifier);
    final notifier = ref.watch(SpacesViewModel.notifier);
    final joinLoadingState = useState(false);

    return GestureDetector(
      onTap: () {
        context.router.navigate(SpaceDetailRoute(spaceId: space.uuid ?? "", space: space));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            border: Border.all(width: 0.6, color: cardBorderColor),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: spacesCardColor
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
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
                                onPressed: joinLoadingState.value ? null : () async {
                                  final isLoggedIn = await SharedPreferencesServices.getIsLoggedIn();
                                  if (isLoggedIn) {
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
                                  }else {
                                    if (!context.mounted) return;
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SignInDialog();
                                      },
                                    );
                                  }
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
                        const Gap(15),
                        Row(
                          children: [
                            Row(
                              children: [
                                Image.asset("assets/images/user_group.png", width: 20, height: 20,),
                                const Gap(5),
                                VerticalBar(color: secondaryColor.withOpacity(0.5), width: 0.5, height: 20,),
                                const Gap(5),
                                Text(
                                  space.spaceMembersCount.toString(),
                                  style: Theme.of(context).textTheme.bodyLarge?.
                                  copyWith(color: secondaryColor.withOpacity(0.8), fontSize: 13),
                                ),

                              ],
                            ),
                            const Gap(30),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.tag_outlined, color: successColor.withOpacity(0.6), size: 20),
                                  const Gap(5),
                                  VerticalBar(color: secondaryColor.withOpacity(0.5), width: 0.5, height: 20,),
                                  const Gap(5),
                                  Row(
                                    children: space.tags?.map((tag) => Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: CardSpaceTag(tag: tag),
                                    )).toList() ?? [],
                                  )
                                ],
                              ),
                            )


                          ],
                        ),
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
