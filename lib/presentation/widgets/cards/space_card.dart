import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/utils/app_utils.dart';
import '../../../core/utils/theme/dark_theme.dart';
class SpaceCard extends StatelessWidget {
  const SpaceCard({super.key});

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
              ClipOval(
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: "https://pbs.twimg.com/profile_images/1727588800627404800/ZKZks_LF_400x400.jpg",
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
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "AudaXious Africa",
                            style: Theme.of(context).textTheme.displayLarge?.
                            copyWith(fontSize: 14),
                          ),
                        ),
                        const Gap(20),
                        Image.asset("assets/images/community_filled.png", width: 20, height: 20,),
                        const Gap(5),
                        Text(
                          "208",
                          style: Theme.of(context).textTheme.bodyMedium?.
                          copyWith(fontSize: 12),
                        )
                      ],
                    ),
                    const Gap(10),
                    Text(
                        shortenStringWithReadMore(
                            "Floxy Pay Wallet is a decentralized Self/Non-Custodian cryptocurrency, and \$FXY is our native token. Your One-Stop CRYPTO HUB! 🚀 Perfect for newcomers and experts. Buy, Sell, Trade, and Smart swap... Read more",
                            150
                        ),
                        style: Theme.of(context).textTheme.bodyLarge
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
