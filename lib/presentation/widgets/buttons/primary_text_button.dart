import 'package:flutter/material.dart';
import '../../../core/utils/app_layout.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../../domain/enums/button_state.dart';

class PrimaryTextButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final ButtonState buttonState;
  final Color? textColor;

  const PrimaryTextButton({
    Key? key,
    this.onPressed,
    required this.buttonText,
    this.buttonState = ButtonState.active,
    this.textColor
  }) : super(key: key);

  @override
  State<PrimaryTextButton> createState() => _PrimaryTextButtonState();
}

class _PrimaryTextButtonState extends State<PrimaryTextButton> {
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return SizedBox(
      height: 50,
      width: size.width,
      child: TextButton(
        onPressed: _getOnPressed(),
        style: TextButton.styleFrom(
          primary: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
          style: Theme.of(context).textTheme.displayMedium?.copyWith(color: widget.textColor ?? greyTextColor, fontSize: 14),
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
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(widget.textColor ?? Colors.white),
              ),
            ),
          ],
        );
      case ButtonState.disabled:
        return Text(
          widget.buttonText,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(color: widget.textColor ?? greyTextColor, fontSize: 14),
        );
    }
  }

  VoidCallback? _getOnPressed() {
    return widget.buttonState == ButtonState.active
        ? widget.onPressed
        : null;
  }
}
