import 'package:audaxious/data/dummy_data.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/viewmodels/home/home_viewmodel.dart';
import 'package:audaxious/presentation/widgets/post.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(HomeViewModel.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("AudaXious Engage"),
        backgroundColor: const Color(0xFF060B12),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.notifications)
          )
        ],
      ),
      body: notifier.viewState.isLoading 
          ? const Center(child: CircularProgressIndicator(strokeWidth: 3)) 
          : !notifier.viewState.isError
          ? Center(child: Text(notifier.error)) 
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: dummyFeeds.length,
              itemBuilder: (context, index) {
                final singleFeed = dummyFeeds[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Post(
                    post: singleFeed,
                  ),
                );
              }
      ),
    );
  }
}
