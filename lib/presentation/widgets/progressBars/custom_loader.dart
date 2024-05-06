import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class CustomLoader extends StatelessWidget {
  Color? color;
  double? size;
  double? strokeWidth;
  CustomLoader({super.key, this.color, this.size, this.strokeWidth});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.inkDrop(
      color: color ?? secondaryColor,
      size: size ?? 20,
    );
  }
}
