import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/domain/models/campaign.dart';
import 'package:audaxious/presentation/viewmodels/campaigns/campaigns_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/task_button.dart';
import 'package:audaxious/presentation/widgets/cards/complete_campaign_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


@RoutePage()
class CampaignDetailsScreen extends HookConsumerWidget {
  Campaign post;
  int postIndex;
  CampaignDetailsScreen({super.key, required this.post, required this.postIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(CampaignsViewModel.notifier);
    final feeds = notifier.campaigns;
    final currentIndex = useState(postIndex);
    final slideInRight = useState(true);

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
      currentIndex.value = postIndex;
      return () {
        animationController.dispose();
      };
    }, [postIndex]);

    useEffect(() {
      animationController.reset();
      animationController.forward();
      return null;
    }, [currentIndex.value]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        backgroundColor: const Color(0xFF060B12),
      ),
      body: notifier.viewState.isLoading
          ? Center(child: CircularProgressIndicator(strokeWidth: 3, color: secondaryColor))
          : notifier.viewState.isError ? Center(child: Text(notifier.error),)
          : Column(
              children: [
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
                          CompleteCampaignCard(post: feeds![currentIndex.value]),
                          const Gap(70),
                          Visibility(
                            visible: feeds[currentIndex.value].tasks?.follow != null,
                            child: TaskButton(
                              buttonText: 'Follow',
                              taskIcon: "assets/images/x.png",
                              onPressed: () {},
                            ),
                          ),
                          const Gap(15),
                          Visibility(
                            visible: feeds[currentIndex.value].tasks?.like != null,
                            child: TaskButton(
                              buttonText: 'Like',
                              taskIcon: "assets/images/un_like.png",
                              onPressed: () {},
                            ),
                          ),
                          const Gap(15),
                          Visibility(
                            visible: feeds[currentIndex.value].tasks?.repost != null,
                            child: TaskButton(
                              buttonText: 'Repost',
                              taskIcon: "assets/images/repost.png",
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  child: notifier.viewState.isError
                      ? Text(notifier.error)
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          slideInRight.value = false;
                          if (currentIndex.value > 0) {
                            currentIndex.value--;
                          } else if (currentIndex.value == 0) {
                            currentIndex.value = feeds.length - 1;
                          }
                        },
                          child: Text(
                              "Prev",
                              style: Theme.of(context).textTheme.displayLarge
                                  ?.copyWith(color: secondaryColor, fontSize: 14)
                          )
                      ),
                      TextButton(
                        onPressed: () {
                          slideInRight.value = true;
                          currentIndex.value++;
                          if (currentIndex.value == feeds.length) {
                            currentIndex.value = 0;
                          }
                        },
                        child: Text(
                            "Next",
                            style: Theme.of(context).textTheme.displayLarge
                                ?.copyWith(color: secondaryColor, fontSize: 14)
                        ),
                      ),
                    ],
                  ),
                ),
              ],
      ),
    );
  }
}
