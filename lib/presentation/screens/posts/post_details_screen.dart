import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/widgets/buttons/task_button.dart';
import 'package:audaxious/presentation/widgets/complete_post.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/dummy_data.dart';
import '../../viewmodels/posts/posts_viewmodel.dart';

@RoutePage()
class PostDetailsScreen extends HookConsumerWidget {
  Map<String, dynamic> post;
  int postIndex;
  PostDetailsScreen({super.key, required this.post, required this.postIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(PostsViewModel.notifier);
    final feeds = dummyFeeds;

    return Scaffold(
      appBar: AppBar(
        title:  Text(postIndex.toString()),
        backgroundColor: const Color(0xFF060B12),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CompletePost(post: feeds[postIndex]),
                const Gap(70),
                Visibility(
                  visible: feeds[postIndex]['tasks']['follow'] != null,
                  child: TaskButton(
                    buttonText: 'Follow',
                    taskIcon: "assets/images/x.png",
                    onPressed: () {},
                  )
                ),
                const Gap(15),
                Visibility(
                    visible: feeds[postIndex]['tasks']['like'] != null,
                    child: TaskButton(
                    buttonText: 'Like',
                      taskIcon: "assets/images/un_like.png",
                      onPressed: () {},
                  )
                ),
                const Gap(15),
                Visibility(
                    visible: feeds[postIndex]['tasks']['repost'] != null,
                  child: TaskButton(
                    buttonText: 'Repost',
                    taskIcon: "assets/images/repost.png",
                    onPressed: () {},
                  )
                )
              ],
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
            child: !notifier.viewState.isError
                ? Text(notifier.error)
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      if (postIndex > 0) {
                        postIndex--;
                      }else if (postIndex == 0) {
                        postIndex = feeds.length - 1;
                      }
                    },
                    child: const Text("Prev", style: TextStyle(color: Color(0xFF79C4EC)))
                ),
                TextButton(
                    onPressed: () {
                      postIndex++;
                      if (postIndex == feeds.length) {
                        postIndex = 0;
                      }
                    },
                    child: const Text("Next", style: TextStyle(color: Color(0xFF79C4EC)))
                )
              ],
            ),
          )
        ] ,
      ),

    );
  }
}
