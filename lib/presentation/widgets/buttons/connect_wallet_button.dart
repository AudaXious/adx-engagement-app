import 'package:flutter/material.dart';
import '../../../core/utils/app_layout.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../../domain/enums/button_state.dart';

class ConnectWalletButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final ButtonState buttonState;
  final String? icon;

  const ConnectWalletButton({
    Key? key,
    this.onPressed,
    required this.buttonText,
    this.buttonState = ButtonState.active,
    this.icon
  }) : super(key: key);

  @override
  State<ConnectWalletButton> createState() => _ConnectWalletButtonState();
}

class _ConnectWalletButtonState extends State<ConnectWalletButton> {
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
        return accentColor;
      case ButtonState.loading:
        return accentColor.withOpacity(0.3);
      case ButtonState.disabled:
        return accentColor.withOpacity(0.8);
    }
  }

  Widget _buildButtonChild() {
    switch (widget.buttonState) {
      case ButtonState.active:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: widget.icon != null ? true : false ,
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: Image.asset("${widget.icon}", width: 24, height: 24),
              ),
            ),
            Text(
              widget.buttonText,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(color: blackTextColor, fontSize: 16),
            )
          ],
        );
      case ButtonState.loading:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Initializing...",
              style: Theme.of(context).textTheme.displaySmall?.copyWith(color: fadedTextColor, fontSize: 16),
            ),
          ],
        );
      case ButtonState.disabled:
        return Text(
          widget.buttonText,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(color: fadedTextColor, fontSize: 16),
        );
    }
  }

  VoidCallback? _getOnPressed() {
    return widget.buttonState == ButtonState.active
        ? widget.onPressed
        : null;
  }
}



