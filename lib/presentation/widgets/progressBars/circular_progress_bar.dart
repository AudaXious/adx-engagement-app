import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:flutter/material.dart';
class CircularProgressBar extends StatelessWidget {
  Color? color;
  double? size;
  double? strokeWidth;
  CircularProgressBar({super.key, this.color, this.size, this.strokeWidth});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 40,
      height: size ?? 40,
      child: CircularProgressIndicator(
        color: color ?? secondaryColor,
        strokeWidth: strokeWidth ?? 3.0,
      ),
    );
  }
}
