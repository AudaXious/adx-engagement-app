import 'package:audaxious/presentation/widgets/empty_result_found_illustration.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RaffleScreen extends StatelessWidget {
  const RaffleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Raffles",
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
