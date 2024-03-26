import 'package:flutter/material.dart';

import '../../core/utils/theme/dark_theme.dart';
class SpaceTag extends StatelessWidget {
  String tag;
  SpaceTag({super.key, required this.tag});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 0.2, color: secondaryColor.withOpacity(0.6)),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        // color: lightTeal.withOpacity(0.2),
      ),
      child: Text(
        tag,
        style: Theme.of(context).textTheme.bodyLarge
      ),
    );
  }
}
