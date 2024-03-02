import 'package:flutter/material.dart';
import 'custom_radio_button_with_icon_and_text.dart';

class CustomRadioGroupTabsHorizontal extends StatefulWidget {
  final void Function(String value)? onValueChanged;
  final List<Map<String, dynamic>> radioButtons;

  const CustomRadioGroupTabsHorizontal({
    Key? key,
    this.onValueChanged,
    required this.radioButtons
  }) : super(key: key);

  @override
  State<CustomRadioGroupTabsHorizontal> createState() => _CustomRadioGroupTabsHorizontalState();
}

class _CustomRadioGroupTabsHorizontalState extends State<CustomRadioGroupTabsHorizontal> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widget.radioButtons.asMap().entries.map((entry) {
        final index = entry.key;
        final radioButton = entry.value;
        final isActive = selectedIndex == index;

        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomRadioButtonWithIconAndText(
              icon: radioButton['icon'],
              title: radioButton['title'],
              isActive: isActive,
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onValueChanged?.call(radioButton['value']);
              },
              value: radioButton['value'],
            ),
          ),
        );
      }).toList(),
    );
  }
}
