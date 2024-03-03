import 'package:flutter/material.dart';
import '../../../core/utils/app_layout.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../../domain/enums/button_state.dart';

class PrimaryButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final ButtonState buttonState;

  const PrimaryButton({
    Key? key,
    this.onPressed,
    required this.buttonText,
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
        return primaryColor;
      case ButtonState.loading:
        return primaryColor.withOpacity(0.7);
      case ButtonState.disabled:
        return primaryColor.withOpacity(0.8);
    }
  }

  Widget _buildButtonChild() {
    switch (widget.buttonState) {
      case ButtonState.active:
        return Text(
          widget.buttonText,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(color: blackTextColor, fontSize: 16),
        );
      case ButtonState.loading:
        return Stack(
          alignment: Alignment.center,
          children: [
            Text(
              widget.buttonText,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.transparent),
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
          style: Theme.of(context).textTheme.displaySmall?.copyWith(color: blackTextColor, fontSize: 16),
        );
    }
  }

  VoidCallback? _getOnPressed() {
    return widget.buttonState == ButtonState.active
        ? widget.onPressed
        : null;
  }
}



