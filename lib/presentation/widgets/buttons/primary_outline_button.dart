import 'package:audaxious/presentation/widgets/progressBars/circular_progress_bar.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/app_layout.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../../domain/enums/button_state.dart';

class PrimaryOutlineButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final ButtonState buttonState;
  final Color? borderColor;
  double? progressBarSize;
  double? borderRadius;

  PrimaryOutlineButton({
    Key? key,
    this.onPressed,
    required this.buttonText,
    this.buttonState = ButtonState.active,
    this.borderColor,
    this.progressBarSize,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<PrimaryOutlineButton> createState() => _PrimaryOutlineButtonState();
}

class _PrimaryOutlineButtonState extends State<PrimaryOutlineButton> {
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return SizedBox(
      height: 50,
      width: size.width,
      child: OutlinedButton(
        onPressed: _getOnPressed(),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: BorderSide(
            color: widget.borderColor ?? secondaryColor
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.borderRadius ?? 30)),
        ),
        child: _buildButtonChild(),
      ),
    );
  }

  Widget _buildButtonChild() {
    switch (widget.buttonState) {
      case ButtonState.active:
        return Text(
          widget.buttonText,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(color: greyTextColor, fontSize: 14),
        );
      case ButtonState.loading:
        return Stack(
          alignment: Alignment.center,
          children: [
            Text(
              widget.buttonText,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.transparent),
            ),
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressBar(color: accentColor, size: 20,),
            ),
          ],
        );
      case ButtonState.disabled:
        return Text(
          widget.buttonText,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(color: fadedTextColor, fontSize: 14),
        );
    }
  }

  VoidCallback? _getOnPressed() {
    return widget.buttonState == ButtonState.active
        ? widget.onPressed
        : null;
  }
}



