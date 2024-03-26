import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomRadioButtonWithIconAndText extends StatelessWidget {
  String? icon;
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final String value;

    CustomRadioButtonWithIconAndText({
    super.key,
    this.icon,
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
        padding: const EdgeInsets.only(top: 13),
        decoration: BoxDecoration(
          color: isActive ? activeTabColor : backgroundColor
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                    visible: icon != null,
                    child: Image.asset(
                        icon ?? "",
                        width: 24,
                        height: 24,
                        color: isActive ? blackTextColor : Colors.white
                    )
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: isActive ? secondaryColor : Colors.white,
                      fontSize: 14
                  ),
                )
              ],
            ),
            const Gap(10),
            Container(
              width: 400,
              height: 5,
              decoration: BoxDecoration(
                color: isActive ? secondaryColor : backgroundColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
