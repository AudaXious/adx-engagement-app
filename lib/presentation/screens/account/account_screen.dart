import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../widgets/alerts/empty_result_found_illustration.dart';

@RoutePage()
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: NoResultFoundIllustration(
          title: "Coming soon...",
          description: "Still under development. Stay glued...",
          illustration: "assets/images/empty_spaces_cards.png",
        ),
      )
    );
  }
}
