import 'package:audaxious/core/utils/app_layout.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/viewmodels/spaces/space_detail_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/custom_radio_group_tabs_horizontal.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_button.dart';
import 'package:audaxious/presentation/widgets/progressBars/circular_progress_bar.dart';
import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../../domain/enums/button_state.dart';
import '../../../domain/models/leader_board.dart';
import '../../../domain/models/space.dart';
import '../../widgets/alerts/custom_toast.dart';
import '../../widgets/alerts/empty_result_found_illustration.dart';
import '../../widgets/cards/campaign_card.dart';
import '../../widgets/leader_board_item.dart';
import '../../widgets/space_tag.dart';

@RoutePage()
class SpaceDetailScreen extends HookConsumerWidget {
  String spaceId;
  Space? space;
  SpaceDetailScreen({super.key, required this.spaceId, this.space});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = AppLayout.getSize(context);
    final reader = ref.read(SpacesDetailsViewModel.notifier.notifier);
    final notifier = ref.watch(SpacesDetailsViewModel.notifier);
    final activeTab = useState("campaigns");

    void callAPIs() async {
      await Future.delayed(const Duration(milliseconds: 200));
      // reader.getSpaceDetail(spaceId);
      reader.getCampaignsBySpaceId(spaceId);
    }

    useEffect(() {
      callAPIs();
      return () {
        // Reset the state to initial values
        activeTab.value = "campaigns";
      };
    }, []);

    if (notifier.space != null) {
      space = notifier.space;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Space",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  child: space?.coverURL == null
                      ? Container(
                    width: double.infinity,
                    height: coverImageHeight,
                    color: Colors.grey,
                  )
                      : CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: space?.coverURL ?? "",
                    width: double.infinity,
                    height: coverImageHeight,
                  ),
                ),
                Positioned(
                    left: size.width / 2,
                    top: 10,
                    child: notifier.spaceInfoViewState.isLoading
                        ? CircularProgressBar(size: 20) : const SizedBox()
                ),
                Positioned(
                  top: coverImageHeight - profileImageHeight / 2,
                  left: 20,
                  child:  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1)
                    ),
                    child: ClipOval(
                      child: space?.profileURL == null
                          ? Image.asset(
                        "assets/images/dumm_profile.png",
                        width: profileImageHeight,
                        height: profileImageHeight,
                      )
                          : CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: space?.profileURL ?? "",
                        placeholder: (context, url) => CircularProgressBar(),
                        width: profileImageHeight,
                        height: profileImageHeight,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              space?.title ?? "",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const Gap(3),
                            Text(
                              "0 active campaign",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: lightGreen),
                            )
                          ],
                        ),
                      ),
                      const Gap(50),
                      SizedBox(
                          width: 140,
                          height: 32,
                          child: PrimaryButton(
                              onPressed: () async {
                                bool isSuccessful = await reader.joinSpace(space?.uuid ?? "");
                                if (isSuccessful) {
                                  CustomToast.show(
                                    context: context,
                                    title: "Success",
                                    description: notifier.message,
                                    type: ToastificationType.success,
                                  );
                                }else {
                                  CustomToast.show(
                                    context: context,
                                    title: "Error",
                                    description: notifier.message,
                                    type: ToastificationType.error,
                                  );
                                }
                              },
                              buttonText: "Join space",
                              borderRadius: 30,
                              buttonState: notifier.joinSpaceViewState. isLoading
                                  ? ButtonState.loading
                                  : ButtonState.active
                          )
                      )
                    ],
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.2, color: secondaryColor),
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                          // color: lightTeal.withOpacity(0.2),
                        ),
                        child: Row(
                          children: [
                            Image.asset("assets/images/user_group.png", width: 24, height: 24,),
                            const Gap(5),
                            Text(
                              space?.spaceMembersCount.toString() ?? "",
                              style: Theme.of(context).textTheme.bodyMedium?.
                              copyWith(color: secondaryColor.withOpacity(0.9)),
                            ),
        
                          ],
                        ),
                      ),
                      const Gap(20),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset("assets/images/internet.png", width: 24, height: 24,),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset("assets/images/twitter.png", width: 24, height: 24,),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset("assets/images/discord.png", width: 24, height: 24,),
                      ),
                    ],
                  ),
                  const Gap(20),
                  Text(
                      space?.description ?? "",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: greyTextColor)
                  )
                ],
              ),
            ),
            const Gap(20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                  children: space!.tags!.map((tag) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: SpaceTag(tag: tag,))).toList()
              ),
            ),
            const Gap(30),
            CustomRadioGroupTabsHorizontal(
              radioButtons: [
                {
                  'title': 'Campaigns',
                  'value': 'campaigns'
                },
                {
                  'title': 'Leaderboard',
                  'value': 'leaderboard'
                }
              ],
              onValueChanged: (value) {
                switch (value) {
                  case "campaigns":
                    activeTab.value = value;
                    reader.getCampaignsBySpaceId(spaceId);
                    break;
                  case "leaderboard":
                    activeTab.value = value;
                    break;
                  default:
                    break;
                }
              },
            ),
            const Gap(20),
            activeTab.value == "campaigns"
                ? Container(
                child: notifier.spaceCampaignsViewState.isLoading
                    ? Center(child: CircularProgressBar(size: 20))
                    : notifier.spaceCampaignsViewState.isError
                    ? Center(child: Text(notifier.error))
                    : (notifier.campaigns == null || notifier.campaigns!.isEmpty)
                    ? NoResultFoundIllustration(
                        title: "No campaign",
                        description: "When campaigns are created in this space, it'll appear here.",
                        illustration: "assets/images/empty_spaces_cards.png",
                     )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: notifier.campaigns?.length,
                        itemBuilder: (context, index) {
                          final singleFeed = notifier.campaigns?[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: CampaignCard(
                              campaign: singleFeed!,
                              postIndex: index,
                            ),
                          );
                        }
                )
            )
                : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.6, color: cardBorderColor),
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        color: spacesCardColor
                        ),
                      child: Column(
                        children: [
                          Image.asset("assets/images/ranking.png", width: 50, height: 50),
                          const Gap(10),
                          Text(
                            "Your achievements",
                            style: Theme.of(context).textTheme.displayMedium,
                            textAlign: TextAlign.center,
                          ),
                          const Gap(4),
                          Text(
                            "You have no ranking in this community, complete task to become top of the leader-board",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: greyTextColor),
                            textAlign: TextAlign.center,

                          ),
                          const Gap(20),
                          PrimaryButton(
                            buttonText: "Commence task",
                            onPressed: () {},
                          )
                        ]
                      ),
                    ),
                    const Gap(20),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.6, color: cardBorderColor),
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                          color: spacesCardColor
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Your achievements",
                              style: Theme.of(context).textTheme.displayMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Divider(
                            color: dividerColor.withOpacity(0.2),
                            thickness: 0.2,
                          ),
                          const Gap(20),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                LeaderBoardItem(leaderBoard: LeaderBoard(id: 1, profile: null, points: 140, username: "David Audu"),),
                                LeaderBoardItem(leaderBoard: LeaderBoard(id: 2, profile: null, points: 120, username: "Eddidiong Eddie"),),
                                LeaderBoardItem(leaderBoard: LeaderBoard(id: 3, profile: null, points: 102, username: "Jimoh Ahmed"),),
                                LeaderBoardItem(leaderBoard: LeaderBoard(id: 4, profile: null, points: 90, username: "Damilola Aleyeni"),),
                                LeaderBoardItem(leaderBoard: LeaderBoard(id: 5, profile: null, points: 45, username: "Malik Wasiu")),
                                LeaderBoardItem(leaderBoard: LeaderBoard(id: 6, profile: null, points: 25, username: "Shola Otitoju")),
                              ],
                            ),
                          )

                        ]
                      ),
                    ),
                  ],
                ),
            const Gap(200),
          ],
        ),
      )
    );
  }
}
