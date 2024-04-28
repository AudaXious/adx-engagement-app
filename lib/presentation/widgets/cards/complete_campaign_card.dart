import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:toastification/toastification.dart';

import '../../../core/utils/app_utils.dart';
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
                      Image.asset("assets/images/task.png", width: 12, height: 12, color: taskChipBorderColor.withOpacity(0.6)),
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
                          campaign.description ?? "",
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
                          // Container(
                          //   padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                          //   decoration: BoxDecoration(
                          //     border: Border.all(width: 0.2, color: secondaryColor.withOpacity(0.4)),
                          //     borderRadius: const BorderRadius.all(Radius.circular(15)),
                          //     // color: lightTeal.withOpacity(0.2),
                          //   ),
                          //   child: Row(
                          //     children: [
                          //       Image.asset("assets/images/user_group.png", width: 20, height: 20,),
                          //       const Gap(5),
                          //       Text(
                          //         campaign.participants.toString(),
                          //         style: Theme.of(context).textTheme.bodyMedium?.
                          //         copyWith(color: secondaryColor.withOpacity(0.9)),
                          //       ),
                          //
                          //     ],
                          //   ),
                          // ),
                          Row(
                            children: [
                              Image.asset("assets/images/people.png", width: 16, height: 16, color: secondaryColor,),
                              const Gap(5),
                              // VerticalBar(color: secondaryColor.withOpacity(0.5), width: 0.5, height: 20,),
                              // const Gap(5),
                              Text(
                                campaign.participants.toString(),
                                style: Theme.of(context).textTheme.bodyLarge?.
                                copyWith(color: secondaryColor.withOpacity(0.8), fontSize: 11),
                              ),

                            ],
                          ),
                          const Spacer(),
                          Image.asset("assets/images/timer.png", width: 14, height: 14, color: lightGold.withOpacity(0.6)),
                          const Gap(3),
                          Text(
                            formatEndDate(campaign.endDate ?? ""),
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
