import 'dart:async';

import 'package:audaxious/core/utils/app_layout.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/viewmodels/spaces/space_detail_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/custom_radio_group_tabs_horizontal.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_button.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_outline_button.dart';
import 'package:audaxious/presentation/widgets/progressBars/circular_progress_bar.dart';
import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/services/shared_preferences_services.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../../domain/enums/button_state.dart';
import '../../../domain/enums/join_space_button_state.dart';
import '../../../domain/models/space.dart';
import '../../widgets/alerts/empty_result_found_illustration.dart';
import '../../widgets/alerts/sign_in_dialog.dart';
import '../../widgets/alerts/un_follow_dialog.dart';
import '../../widgets/buttons/join_and_leave_space_button.dart';
import '../../widgets/cards/campaign_card.dart';
import '../../widgets/leader_board_item.dart';
import '../../widgets/space_tag.dart';
import '../../widgets/vertical_bar.dart';

@RoutePage()
class SpaceDetailScreen extends HookConsumerWidget {
  String spaceId;
  Space? space;
  SpaceDetailScreen({super.key, required this.spaceId, this.space});

  late bool isJoined;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = AppLayout.getSize(context);
    final reader = ref.read(SpacesDetailsViewModel.notifier.notifier);
    final notifier = ref.watch(SpacesDetailsViewModel.notifier);
    final activeTab = useState("campaigns");
    final isMemberState = useState<bool?>(null);
    final buttonState = useState<JoinSpaceButtonState>(JoinSpaceButtonState.join);

    useEffect(() {
      if (space != null) {
        isMemberState.value = space?.isMember;
        if (space!.isMember!) {
          buttonState.value = JoinSpaceButtonState.joined;
        }
      }
      return () {};
    }, []);

    Future<void> callAPIs() async {
      await Future.delayed(const Duration(milliseconds: 200));
      if (space == null) {
        final spaceDetail = await reader.getSpaceDetail(spaceId);
        if (spaceDetail != null) {
          space = spaceDetail;
          isMemberState.value = space?.isMember;
        }
      }
      reader.getCampaignsBySpaceId(spaceId);
    }

    useEffect(() {
      callAPIs();
      return () {
        // Reset the state to initial values
        space = null;
        activeTab.value = "campaigns";
      };
    }, []);

    return Scaffold(
            appBar: AppBar(
              title: Text(
                "Space",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            body: notifier.spaceInfoViewState.isLoading
                ? const Center(child: CircularProgressIndicator(strokeWidth: 3))
                : notifier.spaceInfoViewState.isError ? Center(child: Text(notifier.error),)
                : LiquidPullToRefresh(
                    onRefresh: callAPIs,
                    backgroundColor: secondaryColor,
                    color: backgroundColor,
                    height: 50,
                    animSpeedFactor: 2,
                    borderWidth: 5,
                    showChildOpacityTransition: false,
                  child: SingleChildScrollView(
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
                                child: Container(
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
                              ),

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
                                          Row(
                                            children: [
                                              Text(
                                                space?.title ?? "",
                                                style: Theme.of(context).textTheme.displayMedium,
                                              ),
                                              const Gap(2),
                                              Visibility(
                                                  visible: space?.isVerified ?? false,
                                                  child: Image.asset("assets/images/verification_tick.png", width: 18, height: 18,)
                                              ),
                                            ],
                                          ),
                                          const Gap(3),
                                          Text(
                                            space != null && space?.campaignsCount != null
                                                ? space!.campaignsCount! > 1
                                                ? "${space?.campaignsCount} active campaigns"
                                                : "${space?.campaignsCount} active campaign"
                                                : "null",
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: lightGreen),
                                          )
                                        ],
                                      ),
                                    ),
                                    const Gap(50),
                                    JoinAndLeaveSpaceButton(
                                      onPressed: () async {
                                        final isLoggedIn = await SharedPreferencesServices.getIsLoggedIn();
                                        if (isLoggedIn) {
                                          buttonState.value = JoinSpaceButtonState.joined;

                                          if(isMemberState.value! == false) {
                                            isMemberState.value = true;
                                            await reader.joinSpace(space?.uuid ?? "", context);

                                          }else {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return UnFollowDialog();
                                              },
                                            );
                                          }

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
                                    ),

                                  ],
                                ),
                                const Gap(20),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset("assets/images/people.png", width: 18, height: 18, color: secondaryColor),
                                        const Gap(5),
                                        // VerticalBar(color: secondaryColor.withOpacity(0.5), width: 0.5, height: 20,),
                                        // const Gap(5),
                                        Text(
                                          space?.spaceMembersCount.toString() ?? "",
                                          style: Theme.of(context).textTheme.bodyLarge?.
                                          copyWith(color: secondaryColor.withOpacity(0.9)),
                                        ),

                                      ],
                                    ),
                                    const Gap(30),
                                    VerticalBar(color: Colors.white70.withOpacity(0.5), width: 0.5, height: 20,),
                                    IconButton(
                                      onPressed: () {
                                        _openSpaceWebsiteOnBrowser('https://audaxious.com');
                                      },
                                      icon: Image.asset("assets/images/internet.png", width: 14, height: 14, color: Colors.white70,),
                                    ),
                                    VerticalBar(color: Colors.white70.withOpacity(0.5), width: 0.5, height: 20,),
                                    const Gap(5),
                                    IconButton(
                                      onPressed: () {
                                        _openTwitterProfile('https://twitter.com/AudaXious3');
                                      },
                                      icon: Image.asset("assets/images/twitter.png", width: 18, height: 18,  color: Colors.white70),
                                    ),
                                    VerticalBar(color: Colors.white70.withOpacity(0.5), width: 0.5, height: 20,),
                                    const Gap(5),
                                    IconButton(
                                      onPressed: () {
                                        _openTwitterProfile('https://discord.com/invite/');
                                      },
                                      icon: Image.asset("assets/images/discord.png", width: 18, height: 18,  color: Colors.white70),
                                    ),
                                    VerticalBar(color: Colors.white70.withOpacity(0.5), width: 0.5, height: 20,),
                                    const Gap(5),
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
                              children: space?.tags?.map((tag) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: SpaceTag(tag: tag),
                              )).toList() ?? [],
                            ),
                          ),
                          const Gap(30),
                          CustomRadioGroupTabsHorizontal(
                            radioButtons: const [
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
                                  reader.getLeaderBoardBySpaceId(spaceId);
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
                                        "Your Achievements",
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
                                          "All time | View top ranked",
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
                                        child: notifier.spaceLeaderboardViewState.isLoading
                                            ? Center(child: CircularProgressBar(size: 20))
                                            : notifier.spaceLeaderboardViewState.isError
                                            ? Center(child: Text(notifier.error))
                                            : (notifier.leaderBoard == null || notifier.leaderBoard!.isEmpty)
                                            ? NoResultFoundIllustration(
                                          title: "No one here yet",
                                          description: "When users climb the leaderboard in this space, it'll appear here.",
                                          illustration: "assets/images/empty_spaces_cards.png",
                                        )
                                            : ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            itemCount: notifier.leaderBoard?.length,
                                            itemBuilder: (context, index) {
                                              final leaderBoardItem = notifier.leaderBoard?[index];
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 10),
                                                child: LeaderBoardItem(
                                                  leaderBoard: leaderBoardItem!,
                                                  position: index+1,
                                                ),
                                              );
                                            }
                                        ),
                                      )

                                    ]
                                ),
                              ),
                            ],
                          ),
                          const Gap(100),
                        ],
                      ),
                              ),
                )
    );

  }
}

void _openSpaceWebsiteOnBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void _openTwitterProfile(String profileUrl) async {
  if (await canLaunch(profileUrl)) {
    await launch(profileUrl);
  } else {
    throw 'Could not launch $profileUrl';
  }
}

void _openDiscordProfile(String profileUrl) async {
  if (await canLaunch(profileUrl)) {
    await launch(profileUrl);
  } else {
    throw 'Could not launch $profileUrl';
  }
}
