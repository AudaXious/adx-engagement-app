import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomRadioButtonWithIconAndText extends StatelessWidget {
  final String icon;
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final String value;

  const CustomRadioButtonWithIconAndText({
    super.key,
    required this.icon,
    required this.title,
    required this.isActive,
    required this.onTap,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              color: isActive ? secondaryColor : cardBorderColor,
              width: 1.0,
            ),
            color: isActive ? secondaryColor : backgroundColor
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 24,
              height: 24,
                color: isActive ? blackTextColor : Colors.white
            ),
            const Gap(10),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: isActive ? blackTextColor : Colors.white
              ),
            )
          ],
        ),
      ),
    );
  }
}
