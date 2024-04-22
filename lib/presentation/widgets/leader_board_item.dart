import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/utils/constants.dart';
import '../../core/utils/theme/dark_theme.dart';
import '../../domain/models/leader_board.dart';
class LeaderBoardItem extends StatelessWidget {
  LeaderBoard leaderBoard;
  int position;
  LeaderBoardItem({super.key, required this.leaderBoard, required this.position});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(
            position.toString(),
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const Gap(10),
          ClipOval(
            child: leaderBoard.profile == null
                ? Image.asset(
              "assets/images/dumm_profile.png",
              width: cardProfileWidth,
              height: cardProfileHeight,
            )
                : CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: leaderBoard.profile ?? "",
              placeholder: (context, url) => const CircularProgressIndicator(
                color: Color(0xFF79C4EC),
                strokeWidth: 2,
              ),
              width: cardProfileWidth,
              height: cardProfileHeight,
            ),
          ),
          const Gap(10),
          Text(
            leaderBoard.username ?? "",
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Text(
            "${leaderBoard.points} XP",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: lightGold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
