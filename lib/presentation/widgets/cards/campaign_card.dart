import 'package:audaxious/core/utils/app_utils.dart';
import 'package:audaxious/core/utils/constants.dart';
import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/routes/app_router.dart';
import '../../../domain/models/campaign.dart';
import '../buttons/primary_outline_button.dart';

class CampaignCard extends StatelessWidget {
  Campaign campaign;
  int postIndex;
   CampaignCard({
    super.key,
    required this.campaign,
    required this.postIndex,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: const Color(0x0d021418),
      onTap: () {
        context.router.navigate(
            CampaignDetailsRoute(campaign: campaign, campaignIndex: postIndex));
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
                  const Gap(15),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: lightGold.withOpacity(0.5)),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: lightGold.withOpacity(0.1),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Earn | ${campaign.points} XP",
                          style: Theme.of(context).textTheme.bodyMedium?.
                          copyWith(color: lightGold.withOpacity(0.7)),
                        ),
                        const Gap(3),
                        Image.asset("assets/images/cryptocurrency.png", width: 16, height: 16,),
                      ],
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
                              child: campaign.spaceProfile == null
                                  ? Image.asset(
                                "assets/images/dumm_profile.png",
                                width: cardProfileWidth,
                                height: cardProfileHeight,
                              )
                                  : CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: campaign.spaceProfile ?? "",
                                placeholder: (context, url) => const CircularProgressIndicator(
                                  color: Color(0xFF79C4EC),
                                  strokeWidth: 2,
                                ),
                                width: cardProfileWidth,
                                height: cardProfileHeight,
                              ),
                            ),
                            const Gap(8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    campaign.title ?? "",
                                    style: Theme.of(context).textTheme.displaySmall?.
                                    copyWith(fontSize: 16, color: cardTitleColor),
                                  ),
                                  const Gap(5),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/verification_tick.png",
                                        width: verificationBadgeSize,
                                        height: verificationBadgeSize
                                      ),
                                      const Gap(3),
                                      Text(
                                         campaign.spaceTitle ?? "",
                                        style: Theme.of(context).textTheme.bodySmall?.
                                        copyWith(color: greyTextColor),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(15),
                        Text(
                            shortenString(
                                campaign.description ?? "",
                                80
                            ),
                            style: Theme.of(context).textTheme.bodyLarge?.
                            copyWith(color: greyTextColor)
                        ),
                        const Gap(20),
                        Row(
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
                                    campaign.participants.toString(),
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
                        )
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
