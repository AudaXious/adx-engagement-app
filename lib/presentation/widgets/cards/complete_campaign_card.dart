import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/utils/theme/dark_theme.dart';
import '../../../domain/models/campaign.dart';
class CompleteCampaignCard extends StatelessWidget {
  Campaign post;

   CompleteCampaignCard({
    super.key,
    required this.post
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: cardBorderColor),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: cardColor
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: lightTeal),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: lightTeal.withOpacity(0.2),
                ),
                child: Row(
                  children: [
                    Icon(Icons.settings, color: lightTeal, size: 20,),
                    const Gap(3),
                    Text(
                      "Tasks | 0/${post.tasks?.length}",
                      style: Theme.of(context).textTheme.bodyMedium?.
                      copyWith(color: lightTeal),
                    )
                  ],
                ),
              ),
              const Gap(20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: lightGold),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: lightGold.withOpacity(0.2),
                ),
                child: Row(
                  children: [
                    Text(
                      "Engage to earn | 10 BNB",
                      style: Theme.of(context).textTheme.bodyMedium?.
                      copyWith(color: lightGold),
                    ),
                    const Gap(3),
                    Icon(Icons.currency_bitcoin, color: lightGold, size: 20,),
                  ],
                ),
              ),
            ],
          ),
          const Gap(20),
          Row(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: post.spaceProfile ?? "",
                  placeholder: (context, url) => const CircularProgressIndicator(
                    color: Color(0xFF79C4EC),
                    strokeWidth: 2,
                  ),
                  width: 35,
                  height: 35,
                ),
              ),
              const Gap(20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          post.title ?? "",
                          style: Theme.of(context).textTheme.displayLarge?.
                          copyWith(fontSize: 14),
                        ),
                        const Spacer(),
                        Expanded(child: Text(
                          "• 6 days",
                          style: Theme.of(context).textTheme.bodyMedium?.
                          copyWith(fontSize: 12),
                        )
                        )
                      ],
                    ),
                    const Gap(5),
                    Text(
                        post.description ?? "",
                        style: Theme.of(context).textTheme.bodyLarge
                    ),
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
