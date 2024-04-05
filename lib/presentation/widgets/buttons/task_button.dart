import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:audaxious/domain/enums/task_button_state.dart';
import 'package:audaxious/presentation/widgets/progressBars/circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/utils/app_layout.dart';

class TaskButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final String taskIcon;
  final bool isTaskCompleted;
  final TaskButtonState buttonState;

  const TaskButton({
    Key? key,
    this.onPressed,
    required this.buttonText,
    required this.taskIcon,
    this.isTaskCompleted = false,
    this.buttonState = TaskButtonState.active,
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
      case TaskButtonState.active:
        return spacesCardColor.withOpacity(0.7);
      case TaskButtonState.loading:
        return spacesCardColor.withOpacity(0.4);
      case TaskButtonState.completed:
        return spacesCardColor.withOpacity(0.4);
    }
  }

  Widget _buildButtonChild() {
    switch (widget.buttonState) {
      case TaskButtonState.active:
        return Row(
          children: [
            Image.asset(widget.taskIcon, width: 24, height: 24,),
            const Gap(10),
            Expanded(
              child: Text(
                widget.buttonText,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const Spacer(),
            Icon(Icons.refresh_outlined, size: 18, color: greyTextColor)
          ],
        );
      case TaskButtonState.loading:
        return Stack(
          alignment: Alignment.center,
          children: [
            Text(
              widget.buttonText,
              style: const TextStyle(color: Colors.transparent),
            ),
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressBar(color: accentColor,),
            ),
          ],
        );
      case TaskButtonState.completed:
        return Row(
          children: [
            Image.asset(widget.taskIcon, width: 24, height: 24,),
            const Gap(10),
            Expanded(
              child: Text(
                widget.buttonText,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const Spacer(),
            Image.asset("assets/images/checkmark_circle.png", width: 24, height: 24,)
          ],
        );
    }
  }

  VoidCallback? _getOnPressed() {
    return widget.buttonState == TaskButtonState.active
        ? widget.onPressed
        : null;
  }
}



