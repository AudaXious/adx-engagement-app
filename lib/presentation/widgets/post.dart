import 'package:audaxious/core/utils/app_utils.dart';
import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/routes/app_router.dart';
import '../../domain/models/feed.dart';
class Post extends StatelessWidget {
  Feed post;
  int postIndex;
   Post({
    super.key,
    required this.post,
    required this.postIndex,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: const Color(0x0d021418),
      onTap: () {
        context.router.navigate(PostDetailsRoute(post: post, postIndex: postIndex));
      },
      child: Container(
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
                        style: Theme.of(context).textTheme.bodyText2?.
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
                        style: Theme.of(context).textTheme.bodyText2?.
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
                    imageUrl: post.authorProfile ?? "",
                    placeholder: (context, url) => const CircularProgressIndicator(
                      color: Color(0xFF79C4EC),
                      strokeWidth: 2,
                    ),
                    width: 50,
                    height: 50,
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
                            shortenString(post.title ?? "", 20),
                            style: Theme.of(context).textTheme.headline1?.
                            copyWith(fontSize: 14),
                          ),
                          const Spacer(),
                          Expanded(child: Text(
                              "• 6 days",
                            style: Theme.of(context).textTheme.bodyText2?.
                            copyWith(fontSize: 12),
                          )
                          )
                        ],
                      ),
                      const Gap(5),
                      Text(
                          shortenString(post.description ?? "", 70),
                          style: Theme.of(context).textTheme.bodyText1
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
