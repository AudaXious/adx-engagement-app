import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/utils/theme/dark_theme.dart';
class NoResultFoundIllustration extends StatelessWidget {
  String title;
  String description;
  String? illustration;
  NoResultFoundIllustration({
    super.key,
    required this.title,
    required this.description,
    this.illustration
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 70),
      child: (
          Column(
            children: [
              Visibility(
                visible: illustration != null,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: Image.asset(
                      illustration ?? "",
                      width: 275,
                      height: 115
                  ),
                )
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.displayLarge
                    ?.copyWith(color: fadedTextColor, fontSize: 26),
              ),
              const Gap(10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  description,
                  style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(color: fadedTextColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
      ),
    );
  }
}
