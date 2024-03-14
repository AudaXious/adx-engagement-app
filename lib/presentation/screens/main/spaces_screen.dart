
import 'package:audaxious/core/routes/app_router.dart';
import 'package:audaxious/core/utils/view_utils.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/viewmodels/spaces/spaces_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/custom_radio_group_tabs_horizontal.dart';
import 'package:audaxious/presentation/widgets/cards/community_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utils/theme/dark_theme.dart';

@RoutePage()
class SpacesScreen extends HookConsumerWidget {
  const SpacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reader = ref.read(SpacesViewModel.notifier.notifier);
    final notifier = ref.watch(SpacesViewModel.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Spaces",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                context.router.navigate(const CreateCommunityRoute());
              },
              icon: const Icon(Icons.add)
          )
        ]
      ),
      body: notifier.viewState.isLoading
          ? Center(child: CircularProgressIndicator(strokeWidth: 3, color: accentColor))
          : notifier.viewState.isError
          ? Center(child: Text(notifier.error))
          : Column(
              children: [
                const Gap(20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomRadioGroupTabsHorizontal(
                    onValueChanged: (value) {
                    },
                    radioButtons: const [
                      {
                        'icon': 'assets/images/community.png',
                        'title': 'All Communities',
                        'value': 'all_communities'
                      },
                      {
                        'icon': 'assets/images/discord.png',
                        'title': 'My Communities',
                        'value': 'my_communities'
                      },
                    ],
                  ),
                ),
                const Gap(20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.white,
                    decoration: primaryTextFieldWithPrefixIconDecoration(
                        labelText: "Type to search community",
                        prefixIcon: "assets/images/search.png"
                    ),
                  ),
                ),
                const Gap(20),
                const Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Gap(30),
                        CommunityCard(),
                        Gap(30),
                        CommunityCard(),
                        Gap(30),
                        CommunityCard(),
                        Gap(30),
                        CommunityCard(),
                        Gap(20),
                      ],
                    ),
                  ),
                )
              ],
      )

    );
  }
}
