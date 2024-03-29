import 'package:flutter/material.dart';
import '../../../core/utils/app_layout.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../../domain/enums/button_state.dart';
import '../progressBars/circular_progress_bar.dart';

class PrimaryButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final double? borderRadius;
  final ButtonState buttonState;

  const PrimaryButton({
    Key? key,
    this.onPressed,
    required this.buttonText,
    this.borderRadius,
    this.buttonState = ButtonState.active,
  }) : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.borderRadius ?? 8)),
          elevation: 10,
        ),
        child: _buildButtonChild(),
      ),
    );
  }

  Color _getButtonColor() {
    switch (widget.buttonState) {
      case ButtonState.active:
        return secondaryColor;
      case ButtonState.loading:
        return secondaryColor.withOpacity(0.7);
      case ButtonState.disabled:
        return secondaryColor.withOpacity(0.8);
    }
  }

  Widget _buildButtonChild() {
    switch (widget.buttonState) {
      case ButtonState.active:
        return Text(
          widget.buttonText,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(color: blackTextColor, fontSize: 14),
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
              child: CircularProgressBar(color: accentColor, size: 20),
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



