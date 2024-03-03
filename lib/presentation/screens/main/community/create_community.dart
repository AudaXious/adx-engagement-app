import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CreateCommunity extends StatelessWidget {
  const CreateCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Create a Community",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          actions: [
            IconButton(
                onPressed: (){},
                icon: const Icon(Icons.add)
            )
          ]
      ),
    );
  }
}
