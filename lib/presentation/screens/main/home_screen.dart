import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/viewmodels/home/home_viewmodel.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/cards/campaign_card.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(HomeViewModel.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Campaigns",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.notifications)
          )
        ],
      ),
      body: notifier.viewState.isLoading
          ? Center(child: CircularProgressIndicator(strokeWidth: 3, color: accentColor))
          : notifier.viewState.isError
          ? Center(
            child: Container(
              margin: const EdgeInsets.only(top: 70),
              child: (
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                          "assets/images/empty_spaces_cards.png",
                          width: 275,
                          height: 115
                      ),
                      const Gap(40),
                      Text(
                        "Coming soon",
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(color: fadedTextColor, fontSize: 26),
                      ),
                      const Gap(10),
                      Text(
                        "Still under development. Once available will display here",
                        style: Theme.of(context).textTheme.bodyLarge
                            ?.copyWith(color: fadedTextColor),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
              ),
            ),
          )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: notifier.feeds?.length,
              itemBuilder: (context, index) {
                final singleFeed = notifier.feeds?[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CampaignCard(
                    post: singleFeed!,
                    postIndex: index,
                  ),
                );
              }
      ),
    );
  }
}
