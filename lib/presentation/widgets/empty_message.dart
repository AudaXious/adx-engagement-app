import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/utils/theme/dark_theme.dart';
class EmptyMessage extends StatelessWidget {
  const EmptyMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 70),
      child: (
          Column(
            children: [
              Image.asset(
                  "assets/images/empty_spaces_cards.png",
                  width: 275,
                  height: 115
              ),
              const Gap(40),
              Text(
                "No spaces to show",
                style: Theme.of(context).textTheme.displayLarge
                    ?.copyWith(color: fadedTextColor, fontSize: 26),
              ),
              const Gap(10),
              Text(
                "Spaces you join or create will appear here",
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(color: fadedTextColor),
                textAlign: TextAlign.center,
              ),
            ],
          )
      ),
    );
  }
}
