import 'package:flutter/material.dart';
import '../../../core/utils/app_layout.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../../domain/enums/button_state.dart';
import '../../../domain/enums/join_space_button_state.dart';
import '../progressBars/circular_progress_bar.dart';

class JoinSpaceButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final double? borderRadius;
  final JoinSpaceButtonState buttonState;

  const JoinSpaceButton({
    Key? key,
    this.onPressed,
    this.borderRadius,
    this.buttonState = JoinSpaceButtonState.join,
  }) : super(key: key);

  @override
  State<JoinSpaceButton> createState() => _JoinSpaceButtonState();
}

class _JoinSpaceButtonState extends State<JoinSpaceButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: GestureDetector(
        onTap: _getOnPressed(),
        child: _buildButtonChild(),
      ),
    );
  }

  Color _getButtonColor() {
    switch (widget.buttonState) {
      case JoinSpaceButtonState.join:
        return secondaryColor;
      case JoinSpaceButtonState.joined:
        return secondaryColor.withOpacity(0.8);
    }
  }

  Widget _buildButtonChild() {
    switch (widget.buttonState) {
      case JoinSpaceButtonState.join:
        return Container(
          padding: const EdgeInsets.all(5),
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              border: Border.all(width: 0.8, color: lightGold.withOpacity(0.3)),
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              color: lightGold.withOpacity(0.1)
          ),
          child: Image.asset("assets/images/user_add.png", width: 12, height: 12,),
        );

      case JoinSpaceButtonState.joined:
        return Container(
          padding: const EdgeInsets.all(5),
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              border: Border.all(width: 0.8, color: successGreen.withOpacity(0.3)),
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              color: successGreen.withOpacity(0.1)
          ),
          child: Image.asset("assets/images/tick_circle.png", width: 12, height: 12,),
        );
    }
  }

  VoidCallback? _getOnPressed() {
    return widget.buttonState == JoinSpaceButtonState.join
        ? widget.onPressed
        : null;
  }
}



