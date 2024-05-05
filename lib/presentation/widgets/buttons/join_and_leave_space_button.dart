import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/utils/app_layout.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../../domain/enums/button_state.dart';
import '../../../domain/enums/join_space_button_state.dart';
import '../progressBars/circular_progress_bar.dart';


class JoinAndLeaveSpaceButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final double? borderRadius;
  final JoinSpaceButtonState buttonState;

  const JoinAndLeaveSpaceButton({
    Key? key,
    this.onPressed,
    this.borderRadius,
    this.buttonState = JoinSpaceButtonState.join,
  }) : super(key: key);

  @override
  State<JoinAndLeaveSpaceButton> createState() => _JoinAndLeaveSpaceButtonState();
}

class _JoinAndLeaveSpaceButtonState extends State<JoinAndLeaveSpaceButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      // width: 140,
      child: ElevatedButton(
        onPressed: _getOnPressed(),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: _getButtonColor(),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.borderRadius ?? 8)),
          elevation: 0,
        ),
        child: _buildButtonChild(),
      ),
    );
  }

  Color _getButtonColor() {
    switch (widget.buttonState) {
      case JoinSpaceButtonState.join:
        return secondaryColor2;
      case JoinSpaceButtonState.joined:
        return Colors.grey.withOpacity(0.1);
    }
  }

  Widget _buildButtonChild() {
    switch (widget.buttonState) {
      case JoinSpaceButtonState.join:
        return Text(
          "Join",
          style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white70, fontSize: 14),
        );

      case JoinSpaceButtonState.joined:
        return Text(
          "Joined",
          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 14),
        );
    }
  }

  VoidCallback? _getOnPressed() {
    return widget.buttonState == JoinSpaceButtonState.join
        ? widget.onPressed
        : widget.onPressed;
  }
}



