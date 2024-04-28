import 'package:audaxious/presentation/widgets/progressBars/circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/utils/theme/dark_theme.dart';
class Loading extends StatelessWidget {
  String? message;
  Loading({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            CircularProgressBar(size: 80),
            const Positioned(
              top: 80/4,
              left: 0,
              right: 0,
              child: Image(
                image: AssetImage("assets/images/logo.png"),
                width: 40,
                height: 40,
              ),
            )
          ],
        ),
        const Gap(10),
        Text(
            message ?? "",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: fadedTextColor)
        ),
      ],
    );
  }
}
