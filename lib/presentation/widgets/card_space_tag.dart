import 'package:flutter/material.dart';

import '../../core/utils/theme/dark_theme.dart';
class CardSpaceTag extends StatelessWidget {
  String tag;
  CardSpaceTag({super.key, required this.tag});
  @override
  Widget build(BuildContext context) {
    return Text(
        tag,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: secondaryColor.withOpacity(0.8), fontSize: 12)
    );
  }
}
