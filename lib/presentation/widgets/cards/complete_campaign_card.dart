import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:toastification/toastification.dart';

import '../../../core/utils/app_utils.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../../domain/models/campaign.dart';
class CompleteCampaignCard extends StatelessWidget {
  Campaign campaign;

   CompleteCampaignCard({
    super.key,
    required this.campaign
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: taskChipBorderColor.withOpacity(0.5)),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: taskChipBorderColor.withOpacity(0.1),
                  ),
                  child: Row(
                    children: [
                      Image.asset("assets/images/verified_gear.png", width: 16, height: 16,),
                      const Gap(3),
                      Text(
                        "Tasks | 0/${campaign.taskCount}",
                        style: Theme.of(context).textTheme.bodyMedium?.
                        copyWith(color: taskChipBorderColor.withOpacity(0.7)),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
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
          const Gap(10),
          Divider(
            color: dividerColor.withOpacity(0.2),
            thickness: 0.2,
          ),
          const Gap(5),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  campaign.title ?? "",
                                  style: Theme.of(context).textTheme.displaySmall?.
                                  copyWith(fontSize: 24, color: cardTitleColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(15),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                          demoText ?? "",
                          style: Theme.of(context).textTheme.bodyLarge?.
                          copyWith(color: greyTextColor)
                      ),
                    ),
                    const Gap(20),
                    Divider(
                      color: dividerColor.withOpacity(0.2),
                      thickness: 0.2,
                    ),
                    const Gap(5),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.2, color: secondaryColor.withOpacity(0.4)),
                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                              // color: lightTeal.withOpacity(0.2),
                            ),
                            child: Row(
                              children: [
                                Image.asset("assets/images/user_group.png", width: 24, height: 24,),
                                const Gap(5),
                                Text(
                                  "2.6k",
                                  style: Theme.of(context).textTheme.bodyMedium?.
                                  copyWith(color: secondaryColor.withOpacity(0.6)),
                                ),

                              ],
                            ),
                          ),
                          const Spacer(),
                          Image.asset("assets/images/time_icon.png", width: 16, height: 16, color: taskChipBorderColor.withOpacity(0.6)),
                          const Gap(5),
                          Text(
                            "2d : 2h : 38m Left",
                            style: Theme.of(context).textTheme.bodyMedium?.
                            copyWith(color: lightGold.withOpacity(0.7)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
