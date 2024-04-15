import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
class ActiveCampaign extends StatelessWidget {
  int activeCampaign;
  ActiveCampaign({super.key, required this.activeCampaign});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: activeCampaignBgColor,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
      ),
      child: Row(
        children: [
          Image.asset("assets/images/award.png", color: const Color(0xFFEEA307), width: 24, height: 24,),
          const Gap(20),
          Text(activeCampaign > 1
              ? "$activeCampaign active campaigns"
              : "$activeCampaign active campaign",
              style: Theme.of(context).textTheme.bodyLarge)
        ],
      ),
    );
  }
}
