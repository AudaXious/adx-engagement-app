import 'package:audaxious/core/routes/app_router.dart';
import 'package:audaxious/core/utils/app_utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
class CompletePost extends StatelessWidget {
  Map<String, dynamic> post;
  
   CompletePost({
    super.key,
    required this.post
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: Row(
                  children: [
                    const Icon(Icons.settings, color: Color(0xFF7AE7E7), size: 20,),
                    const Gap(3),
                    Text(
                      "Tasks | 0/${post['tasks'].length.toString()}",
                      style: const TextStyle(
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
          const Gap(10),
          const Divider(color: Color(0xFF1D3050), thickness: 0.5,),
          const Gap(20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: post['author_profile'] ?? "",
                            placeholder: (context, url) => const CircularProgressIndicator(
                              color: Color(0xFF79C4EC),
                              strokeWidth: 2,
                            ),
                            width: 35,
                            height: 35,
                          ),
                        ),
                        const Gap(5),
                        Text(
                          post['title'] ?? "",
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
                    const Gap(10),
                    Text(post['description'] ?? ""),
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
