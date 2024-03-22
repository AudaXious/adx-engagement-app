import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/utils/app_layout.dart';
import '../../../domain/enums/button_state.dart';

class TaskButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final String taskIcon;
  final bool isTaskCompleted;
  final ButtonState buttonState;

  const TaskButton({
    Key? key,
    this.onPressed,
    required this.buttonText,
    required this.taskIcon,
    this.isTaskCompleted = false,
    this.buttonState = ButtonState.active,
  }) : super(key: key);

  @override
  State<TaskButton> createState() => _TaskButtonState();
}

class _TaskButtonState extends State<TaskButton> {
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return SizedBox(
      height: 50,
      width: size.width,
      child: ElevatedButton(
        onPressed: _getOnPressed(),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: _getButtonColor(),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 10,
        ),
        child: _buildButtonChild(),
      ),
    );
  }

  Color _getButtonColor() {
    switch (widget.buttonState) {
      case ButtonState.active:
        return Colors.transparent;
      case ButtonState.loading:
        return Colors.transparent.withOpacity(0.7);
      case ButtonState.disabled:
        return Colors.transparent.withOpacity(0.8);
    }
  }

  Widget _buildButtonChild() {
    switch (widget.buttonState) {
      case ButtonState.active:
        return Row(
          children: [
            Image.asset(widget.taskIcon, width: 24, height: 24,),
            const Gap(10),
            Text(
              widget.buttonText,
              style: const TextStyle(color: Colors.white),
            ),
            const Spacer(),
            Icon(widget.isTaskCompleted ? Icons.done : Icons.refresh)
          ],
        );
      case ButtonState.loading:
        return Stack(
          alignment: Alignment.center,
          children: [
            Text(
              widget.buttonText,
              style: const TextStyle(color: Colors.transparent),
            ),
            const SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        );
      case ButtonState.disabled:
        return Text(
          widget.buttonText,
          style: const TextStyle(color: Colors.white),
        );
    }
  }

  VoidCallback? _getOnPressed() {
    return widget.buttonState == ButtonState.active
        ? widget.onPressed
        : null;
  }
}



