import 'package:audaxious/core/routes/app_router.dart';
import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:audaxious/domain/enums/button_state.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/domain/models/campaign.dart';
import 'package:audaxious/presentation/viewmodels/campaigns/campaigns_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_button.dart';
import 'package:audaxious/presentation/widgets/buttons/task_button.dart';
import 'package:audaxious/presentation/widgets/cards/complete_campaign_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

import '../../../core/utils/app_utils.dart';
import '../../../core/utils/constants.dart';


@RoutePage()
class CampaignDetailsScreen extends HookConsumerWidget {
  Campaign campaign;
  int campaignIndex;
  CampaignDetailsScreen({super.key, required this.campaign, required this.campaignIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(CampaignsViewModel.notifier);
    final campaigns = notifier.campaigns;
    final currentIndex = useState(campaignIndex);
    final slideInRight = useState(true);
    final spaceTitle = useState<String?>(null);
    spaceTitle.value = campaigns?[currentIndex.value].spaceTitle;


    final animationController = useAnimationController(
        duration: const Duration(milliseconds: 200)
    );
    final slideInLeftAnimation = useMemoized(() => Tween<Offset>(
        begin: const Offset(1.0, 0.0), end: Offset.zero
    ).animate(animationController));
    final slideInRightAnimation = useMemoized(() => Tween<Offset>(
        begin: const Offset(-1.0, 0.0), end: Offset.zero
    ).animate(animationController));

    useEffect(() {
      currentIndex.value = campaignIndex;
      spaceTitle.value = campaigns?[currentIndex.value].spaceTitle;
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
                                Expanded(
                                  child: Text(
                                    spaceTitle.value ?? "",
                                    style: Theme.of(context).textTheme.headlineMedium?.
                                    copyWith(color: greyTextColor),
                                  ),
                                )
                              ],
                            ),
                            const Gap(5),
                            Row(
                              children: [
                                Image.asset("assets/images/time_icon.png", width: 16, height: 16, color: taskChipBorderColor.withOpacity(0.6)),
                                const Gap(5),
                                Text(
                                  formatEndDate(campaign.endDate ?? ""),
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
                                  child: Text(
                                    "${campaign.points} XP",
                                    style: Theme.of(context).textTheme.bodyMedium?.
                                    copyWith(color: lightGold.withOpacity(0.7)),
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
                          const Gap(30),
                          Visibility(
                            visible: campaigns[currentIndex.value].tasks?.follow == null,
                            child: TaskButton(
                              buttonText: 'Join ${spaceTitle.value}',
                              taskIcon: "assets/images/user_group.png",
                              onPressed: () {},
                            ),
                          ),
                          const Gap(15),
                          Visibility(
                            visible: campaigns[currentIndex.value].tasks?.follow == null,
                            child: TaskButton(
                              buttonText: 'Follow',
                              taskIcon: "assets/images/x.png",
                              onPressed: () {},
                            ),
                          ),
                          const Gap(15),
                          Visibility(
                            visible: campaigns[currentIndex.value].tasks?.like == null,
                            child: TaskButton(
                              buttonText: 'Like',
                              taskIcon: "assets/images/un_like.png",
                              onPressed: () {},
                            ),
                          ),
                          const Gap(15),
                          Visibility(
                            visible: campaigns[currentIndex.value].tasks?.repost == null,
                            child: TaskButton(
                              buttonText: 'Repost',
                              taskIcon: "assets/images/repost.png",
                              onPressed: () {},
                            ),
                          ),
                          const Gap(50),
                          const PrimaryButton(
                            buttonText: "Claim reward",
                            buttonState: ButtonState.disabled,
                          )
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
}
