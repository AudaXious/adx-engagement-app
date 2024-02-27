import 'package:audaxious/core/utils/app_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
class Post extends StatelessWidget {
  final int id;
  final String? authorProfile;
  final String title;
  final String descriptions;
  final int points;
  final String reward;
  final bool? follow;
  final bool? like;
  final bool? repost;
  
  const Post({
    super.key,
    required this.id,
    this.authorProfile,
    required this.title,
    required this.descriptions,
    required this.points,
    required this.reward,
    this.follow,
    this.like,
    this.repost,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: const Color(0x0d021418),
      onTap: () {},
      child: Container(
        // margin: const EdgeInsets.symmetric(vertical: 15),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: const Color(0xFF1D3050)),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: const Color(0x0d51c7e1)
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: const Color(0xFF51C7E1)),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: const Color(0x1A51C7E1),
                  ),
                  child:  const Row(
                    children: [
                      Icon(Icons.settings, color: Color(0xFF7AE7E7), size: 20,),
                      Gap(3),
                      Text(
                        "Tasks | 00/10",
                        style: TextStyle(
                            color: Color(0xFF7AE7E7),
                            fontSize: 12
                        ),
                      )
                    ],
                  ),
                ),
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: const Color(0xFFE1D356)),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: const Color(0x1A51C7E1),
                  ),
                  child:  const Row(
                    children: [
                      Text(
                        "Engage to earn | 10 BNB",
                        style: TextStyle(
                            color: Color(0xFFE1D356),
                            fontSize: 12
                        ),
                      ),
                      Gap(3),
                      Icon(Icons.currency_bitcoin, color: Color(0xFFE1D356), size: 20,),
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
                    imageUrl: authorProfile ?? "",
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
                            shortenString(title, 20),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          const Expanded(child: Text(
                              "• 6 days",
                            style: TextStyle(fontSize: 12),
                          )
                          )
                        ],
                      ),
                      const Gap(5),
                      Text(shortenString(descriptions, 70)),
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
