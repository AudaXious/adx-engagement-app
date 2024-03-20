import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SpaceDetailScreen extends StatelessWidget {
  const SpaceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Space",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        // centerTitle: true,
      ),
    );
  }
}
