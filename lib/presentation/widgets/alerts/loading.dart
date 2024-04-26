import 'package:audaxious/presentation/widgets/progressBars/circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/utils/theme/dark_theme.dart';
class Loading extends StatelessWidget {
  String? message;
  Loading({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressBar(size: 12),
        const Gap(5),
        Text(
            message ?? "",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: fadedTextColor)
        ),
      ],
    );
  }
}
