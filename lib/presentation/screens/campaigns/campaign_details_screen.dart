
import 'package:audaxious/core/routes/app_router.dart';
import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:audaxious/domain/enums/button_state.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/domain/models/campaign.dart';
import 'package:audaxious/presentation/viewmodels/campaigns/campaigns_viewmodel.dart';
import 'package:audaxious/presentation/widgets/alerts/empty_result_found_illustration.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_button.dart';
import 'package:audaxious/presentation/widgets/buttons/task_button.dart';
import 'package:audaxious/presentation/widgets/cards/complete_campaign_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/services/shared_preferences_services.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/utils/constants.dart';
import '../../../domain/enums/task_button_state.dart';
import '../../widgets/alerts/sign_in_dialog.dart';
import '../../widgets/alerts/verify_twitter_dialog.dart';


@RoutePage()
class CampaignDetailsScreen extends HookConsumerWidget {
  Campaign campaign;
  int campaignIndex;
  CampaignDetailsScreen({
    super.key,
    required this.campaign,
    required this.campaignIndex
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(CampaignsViewModel.notifier);
    final reader = ref.read(CampaignsViewModel.notifier.notifier);
    final campaigns = notifier.campaigns;
    final currentIndex = useState(campaignIndex);
    final slideInRight = useState(true);
    final isSpaceJoined = useState(false);
    final isLiked = useState(false);
    final isFollowed = useState(false);
    final isReposted = useState(false);

    final animationController = useAnimationController(
        duration: const Duration(milliseconds: 200)
    );
    final slideInLeftAnimation = useMemoized(() => Tween<Offset>(
        begin: const Offset(1.0, 0.0), end: Offset.zero
    ).animate(animationController));
    final slideInRightAnimation = useMemoized(() => Tween<Offset>(
        begin: const Offset(-1.0, 0.0), end: Offset.zero
    ).animate(animationController));

    void callAPIs() async {
      await Future.delayed(const Duration(milliseconds: 200));
      reader.getCampaigns();
    }

    useEffect(() {
      callAPIs();
      return () {
        // Reset the state to initial values
      };
    }, []);

    useEffect(() {
      currentIndex.value = campaignIndex;
      return () {
        animationController.dispose();
      };
    }, [campaignIndex]);

    useEffect(() {
      animationController.reset();
      animationController.forward();
      return null;
    }, [currentIndex.value]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Engage with campaign",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        backgroundColor: const Color(0xFF060B12),
      ),
      body: notifier.viewState.isLoading
          ? const Center(child: CircularProgressIndicator(strokeWidth: 3))
          : notifier.viewState.isError ? Center(child: Text(notifier.error),)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  campaigns?[currentIndex.value].spaceTitle ?? "",
                                  style: Theme.of(context).textTheme.headlineMedium?.
                                  copyWith(color: greyTextColor),
                                ),
                                const Gap(2),
                                Visibility(
                                  visible: campaign.isVerified ?? false,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 3),
                                    child: Image.asset(
                                        "assets/images/verification_tick.png",
                                        width: verificationBadgeSize,
                                        height: verificationBadgeSize
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(5),
                            Row(
                              children: [
                                Image.asset("assets/images/timer.png", width: 14, height: 14, color: lightGold.withOpacity(0.6)),
                                const Gap(5),
                                Text(
                                  formatEndDate(campaigns?[currentIndex.value].endDate ?? ""),
                                  style: Theme.of(context).textTheme.bodyMedium?.
                                  copyWith(color: lightGold.withOpacity(0.7)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const Gap(20),
                      SizedBox(
                          width: 140,
                          height: 32,
                          child: PrimaryButton(
                              onPressed: () {
                                context.navigateTo(SpaceDetailRoute(spaceId: campaign.spaceUUID ?? ""));
                              },
                              buttonText: "View space",
                              borderRadius: 30
                          )
                      )
                    ],
                  ),
                ),
                const Gap(15),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SlideTransition(
                      position: slideInRight.value
                          ? slideInLeftAnimation
                          : slideInRightAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CompleteCampaignCard(campaign: campaigns![currentIndex.value]),
                          Container(
                            child: campaigns[currentIndex.value].tasks!.isNotEmpty
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Gap(50),
                                      Text(
                                        "Tasks",
                                        style: Theme.of(context).textTheme.displaySmall,
                                      ),
                                      const Gap(3),
                                      Text(
                                          "Complete each of the following tasks to claim rewards",
                                          style: Theme.of(context).textTheme.bodyLarge?.
                                          copyWith(color: fadedTextColor)
                                      ),
                                      const Gap(10),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                                        decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(16)),
                                            color: cardColor2.withOpacity(0.1)
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Points/Rewards",
                                                style: Theme.of(context).textTheme.headlineMedium,
                                              ),
                                            ),
                                            const Gap(20),
                                            Container(
                                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                              decoration: BoxDecoration(
                                                border: Border.all(width: 0.5, color: lightGold.withOpacity(0.5)),
                                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                color: lightGold.withOpacity(0.1),
                                              ),
                                              child: Row(
                                                children: [
                                                  Image.asset("assets/images/medal.png", width: 12, height: 12, color: lightGold,),
                                                  const Gap(3),
                                                  Text(
                                                    "${campaign.points} XP",
                                                    style: Theme.of(context).textTheme.bodyMedium?.
                                                    copyWith(color: lightGold.withOpacity(0.7)),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const Gap(8),
                                            Container(
                                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                              decoration: BoxDecoration(
                                                border: Border.all(width: 0.5, color: successColor.withOpacity(0.5)),
                                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                color: successColor.withOpacity(0.1),
                                              ),
                                              child: Text(
                                                "${campaign.points} USDT",
                                                style: Theme.of(context).textTheme.bodyMedium?.
                                                copyWith(color: successColor.withOpacity(0.7)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Gap(20),
                                      Column(
                                        children: campaigns[currentIndex.value].tasks?.map((task) {
                                          TaskButtonState buttonState;
                                          switch (task['action']) {
                                            case "join":
                                              buttonState = isSpaceJoined.value
                                                  ? TaskButtonState.completed
                                                  : (notifier.joinSpaceViewState.isLoading
                                                  ? TaskButtonState.loading
                                                  : TaskButtonState.active);
                                              break;
                                            case "like":
                                              buttonState = isLiked.value
                                                  ? TaskButtonState.completed
                                                  : TaskButtonState.active;
                                              break;
                                            case "follow":
                                              buttonState = isFollowed.value
                                                  ? TaskButtonState.completed
                                                  : TaskButtonState.active;
                                              break;
                                            case "repost":
                                              buttonState = isReposted.value
                                                  ? TaskButtonState.completed
                                                  : TaskButtonState.active;
                                              break;
                                            default:
                                              buttonState = TaskButtonState.active;
                                          }

                                          String buttonIcon;
                                          switch (task['action']) {
                                            case "join":
                                              buttonIcon = "assets/images/user_group.png";
                                              break;
                                            case "like":
                                              buttonIcon = "assets/images/un_like.png";
                                              break;
                                            case "follow":
                                              buttonIcon = "assets/images/x.png";
                                              break;
                                            case "repost":
                                              buttonIcon = "assets/images/repost.png";
                                              break;
                                            default:
                                              buttonIcon = "assets/images/user_group.png";
                                          }

                                          return Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: TaskButton(
                                              buttonText: "${capitalizeWord(task['action'])} ${task['action'] == "join" ? "${campaigns[currentIndex.value].spaceTitle}" : ""}",
                                              taskIcon: buttonIcon,
                                              onPressed: () async {
                                                final isLoggedIn = await SharedPreferencesServices.getIsLoggedIn();
                                                final isTwitterVerified = await SharedPreferencesServices.getTwitterVerificationStatus();

                                                if (isLoggedIn) {
                                                  switch (task['action']) {
                                                    case "join":
                                                      bool isSuccessfullyJoined = await reader.joinSpace(campaigns[currentIndex.value].spaceUUID ?? "");
                                                      if (isSuccessfullyJoined) {
                                                        await Future.delayed(const Duration(milliseconds: 500));
                                                        isSpaceJoined.value = true;
                                                      }else {
                                                        isSpaceJoined.value = false;
                                                      }
                                                      break;
                                                    case "follow":
                                                      if (isTwitterVerified) {
                                                        _followTwitterUser(task['url']);
                                                        await Future.delayed(const Duration(milliseconds: 2000));
                                                        isFollowed.value = true;
                                                      }else {
                                                        if (!context.mounted) return;
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return VerifyTwitterDialog();
                                                          },
                                                        );
                                                      }
                                                      break;
                                                    case "like":
                                                      if (isTwitterVerified) {
                                                        _likeTweet(task['url']);
                                                        await Future.delayed(const Duration(milliseconds: 2000));
                                                        isLiked.value = true;
                                                      }else {
                                                        if (!context.mounted) return;
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return VerifyTwitterDialog();
                                                          },
                                                        );
                                                      }
                                                      break;
                                                    case "repost":
                                                      if (isTwitterVerified) {
                                                        _retweetTweet(task['url']);
                                                        await Future.delayed(const Duration(milliseconds: 2000));
                                                        isReposted.value = true;
                                                      }else {
                                                        if (!context.mounted) return;
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return VerifyTwitterDialog();
                                                          },
                                                        );
                                                      }
                                                      break;
                                                    default:
                                                      print("Unidentified task");
                                                      break;
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
                                              buttonState: buttonState,
                                            ),
                                          );
                                        }).toList() ?? [],
                                      ),
                                      const Gap(50),
                                      const PrimaryButton(
                                        buttonText: "Claim reward",
                                        buttonState: ButtonState.disabled,
                                      )
                                    ],
                                 )
                                : NoResultFoundIllustration(
                                    title: "No task yet!",
                                    description: "No task has been added to this campaign. Check back again later.",
                                    illustration: "assets/images/empty_spaces_cards.png",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Gap(20),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  child: notifier.viewState.isError
                      ? Text(notifier.error)
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            slideInRight.value = false;
                            if (currentIndex.value > 0) {
                              currentIndex.value--;

                            } else if (currentIndex.value == 0) {
                              currentIndex.value = campaigns.length - 1;
                            }
                          },
                          icon: Image.asset("assets/images/previous_campaign_btn.png", width: 40, height: 40,)
                      ),
                      IconButton(
                          onPressed: (){
                            slideInRight.value = true;
                            currentIndex.value++;
                            if (currentIndex.value == campaigns.length) {
                              currentIndex.value = 0;
                            }
                          },
                          icon: Image.asset("assets/images/next_campaign_btn.png", width: 40, height: 40,)
                      )
                    ],
                  ),
                ),
              ],
      ),
    );
  }

  void _followTwitterUser(String profileUrl) async {
    String username = extractUsernameFromTwitterUrl(profileUrl);
    final followUrl = 'https://twitter.com/intent/follow?screen_name=$username';
    if (await canLaunch(followUrl)) {
      await launch(followUrl);
    } else {
      throw 'Could not launch $followUrl';
    }
  }

  void _likeTweet(String tweet) async {
    String tweetId = extractTweetIdFromTwitterUrl(tweet);
    final likeUrl = 'https://twitter.com/intent/like?tweet_id=$tweetId';
    if (await canLaunch(likeUrl)) {
      await launch(likeUrl);
    } else {
      throw 'Could not launch $likeUrl';
    }
  }

  void _retweetTweet(String tweet) async {
    String tweetId = extractTweetIdFromTwitterUrl(tweet);
    final retweetUrl = 'https://twitter.com/intent/retweet?tweet_id=$tweetId';
    if (await canLaunch(retweetUrl)) {
      await launch(retweetUrl);
    } else {
      throw 'Could not launch $retweetUrl';
    }
  }

}
