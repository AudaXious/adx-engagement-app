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

import '../../../core/utils/constants.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../../domain/models/space.dart';
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

    final activeTab = useState<String?>(null);

    // final coverUrl = useState<String?>(null);
    // final profileUrl = useState<String?>(null);
    // final title = useState<String?>(null);
    // final description = useState<String?>(null);
    // final spaceMemberCount = useState<int?>(null);
    //
    // coverUrl.value = notifier.space?.coverURL;
    // profileUrl.value = notifier.space?.profileURL;
    // title.value = notifier.space?.title;
    // description.value = notifier.space?.description;
    // spaceMemberCount.value = notifier.space?.spaceMembersCount;

    if (notifier.space != null) {
      space = notifier.space;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Space",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                reader.getSpaceDetail(spaceId ?? "");
              },
              icon: Icon(Icons.refresh)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
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
                            border: Border.all(color: Colors.white, width: 2)
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: profileImageHeight/2,
                          child: space?.profileURL == null
                              ? Image.asset("assets/images/dumm_profile.png", width: profileImageHeight, height: profileImageHeight,)
                              : CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: space?.profileURL ?? "",
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
                                  onPressed: () {},
                                  buttonText: "Join space",
                                  borderRadius: 30
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
                const Gap(40),
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
                        break;
                      case "leaderboard":
                        activeTab.value = value;
                        break;
                      default:
                        break;
                    }
                  },
                ),
                const Gap(30),
                Container(
                  child: activeTab.value == "campaigns"
                      ? SizedBox()
                      : SizedBox(),
                )
              ],
            )
          ],
        ),
      )
    );
  }
}
