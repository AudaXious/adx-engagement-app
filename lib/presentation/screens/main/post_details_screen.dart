import 'package:audaxious/presentation/widgets/buttons/task_button.dart';
import 'package:audaxious/presentation/widgets/complete_post.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

@RoutePage()
class PostDetailsScreen extends StatelessWidget {
  Map<String, dynamic> post;
  PostDetailsScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
        backgroundColor: const Color(0xFF060B12),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CompletePost(post: post),
                const Gap(70),
                Visibility(
                  visible: post['tasks']['follow'] != null,
                  child: TaskButton(
                    buttonText: 'Follow',
                    taskIcon: "assets/images/x.png",
                    onPressed: () {},
                  )
                ),
                const Gap(15),
                Visibility(
                    visible: post['tasks']['like'] != null,
                    child: TaskButton(
                    buttonText: 'Like',
                      taskIcon: "assets/images/un_like.png",
                      onPressed: () {},
                  )
                ),
                const Gap(15),
                Visibility(
                    visible: post['tasks']['repost'] != null,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: (){}, 
                  child: const Text("Prev", style: TextStyle(color: Color(0xFF79C4EC)))
              ),
              TextButton(
                  onPressed: (){},
                  child: const Text("Next", style: TextStyle(color: Color(0xFF79C4EC)))
              )            ],
          )
        ] ,
      ),

    );
  }
}
