import 'package:audaxious/domain/models/space.dart';
import 'package:audaxious/presentation/widgets/buttons/join_space_button.dart';
import 'package:audaxious/presentation/widgets/cards/active_campaign.dart';
import 'package:audaxious/presentation/widgets/progressBars/circular_progress_bar.dart';
import 'package:audaxious/presentation/widgets/vertical_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/routes/app_router.dart';
import '../../../core/services/shared_preferences_services.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../../domain/enums/join_space_button_state.dart';
import '../../viewmodels/spaces/spaces_viewmodel.dart';
import '../alerts/sign_in_dialog.dart';
import '../card_space_tag.dart';

class SpaceCard extends HookConsumerWidget {
  Space space;
  SpaceCard({super.key, required this.space});

  late Space clickedSpace;
  bool isMember = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reader = ref.read(SpacesViewModel.notifier.notifier);
    final buttonState = useState<JoinSpaceButtonState>(JoinSpaceButtonState.join);

    if (space.isMember!) {
      isMember = true;
      buttonState.value = JoinSpaceButtonState.joined;
    }

    return GestureDetector(
      onTap: () {
        print("The new fucking memem $isMember");
        clickedSpace = Space(
            title: space.title,
            description: space.description,
            creatorUUID: space.creatorUUID,
            tags: space.tags,
            links: space.links,
            profileURL: space.profileURL,
            coverURL: space.coverURL,
            spaceMembersCount: space.spaceMembersCount,
            campaignsCount: space.campaignsCount,
            isVerified: space.isVerified,
            isMember: isMember,
            createdAt: space.createdAt,
            updatedAt: space.updatedAt
        );
        context.router.navigate(SpaceDetailRoute(spaceId: space.uuid ?? "", space: clickedSpace));
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
                            Stack(
                              alignment: Alignment.bottomRight,
                              clipBehavior: Clip.none,
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
                                Visibility(
                                  visible: space.isVerified ?? false,
                                  child: Positioned(
                                    top: cardProfileHeight - 15,
                                    child: Image.asset("assets/images/verification_tick.png", width: 16, height: 16,)
                                  ),
                                )
                              ],
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

                            JoinSpaceButton(
                              onPressed: () async {
                                final isLoggedIn = await SharedPreferencesServices.getIsLoggedIn();
                                if (isLoggedIn) {
                                  isMember = true;
                                  buttonState.value = JoinSpaceButtonState.joined;
                                  clickedSpace = Space(
                                      title: space.title,
                                      description: space.description,
                                      creatorUUID: space.creatorUUID,
                                      tags: space.tags,
                                      links: space.links,
                                      profileURL: space.profileURL,
                                      coverURL: space.coverURL,
                                      spaceMembersCount: space.spaceMembersCount,
                                      campaignsCount: space.campaignsCount,
                                      isVerified: space.isVerified,
                                      isMember: isMember,
                                      createdAt: space.createdAt,
                                      updatedAt: space.updatedAt
                                  );
                                 await reader.joinSpace(space.uuid ?? "", context);
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
                              buttonState: buttonState.value,
                            )

                          ],
                        ),
                        const Gap(25),
                        space != null && space.campaignsCount != null
                          ? space.campaignsCount! <= 0
                            ? Text(
                                shortenString(
                                    space.description ?? "",
                                    80
                                ),
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: greyTextColor)
                            )
                            : ActiveCampaign(activeCampaign: space.campaignsCount!)
                            : Text(
                                "null",
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: greyTextColor)
                            ),
                        const Gap(25),
                        Row(
                          children: [
                            Row(
                              children: [
                                Image.asset("assets/images/people.png", width: 16, height: 16, color: secondaryColor),
                                const Gap(5),
                                // VerticalBar(color: secondaryColor.withOpacity(0.5), width: 0.5, height: 20,),
                                // const Gap(5),
                                Text(
                                  space.spaceMembersCount.toString(),
                                  style: Theme.of(context).textTheme.bodyLarge?.
                                  copyWith(color: secondaryColor.withOpacity(0.8), fontSize: 11),
                                ),

                              ],
                            ),
                            const Gap(30),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset("assets/images/hashtag.png", width: 16, height: 16, color: lightGold),
                                  const Gap(5),
                                  VerticalBar(color: secondaryColor.withOpacity(0.5), width: 0.5, height: 20,),
                                  const Gap(2),
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
