import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:flutter/material.dart';

class VerticalBar extends StatelessWidget {
  Color? color;
  double? height;
  double? width;
  VerticalBar({
    super.key,
    this.color,
    this.height,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: color ?? secondaryColor
      ),
      height: height ?? 25,
      width: width ?? 2,
    );
  }
}
