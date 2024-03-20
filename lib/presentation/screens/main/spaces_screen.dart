
import 'package:audaxious/core/routes/app_router.dart';
import 'package:audaxious/core/utils/view_utils.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/viewmodels/spaces/spaces_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/custom_radio_group_tabs_horizontal.dart';
import 'package:audaxious/presentation/widgets/cards/space_card.dart';
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
          // IconButton(
          //     onPressed: (){
          //       context.router.navigate(const CreateCommunityRoute());
          //     },
          //     icon: const Icon(Icons.add)
          // )
        ]
      ),
      body: Expanded(
        child: Column(
          children: [
            // const Gap(20),
            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 10),
            //   child: CustomRadioGroupTabsHorizontal(
            //     onValueChanged: (value) {
            //       switch (value) {
            //         case "all_spaces":
            //           print(value);
            //           reader.getSpaces();
            //           break;
            //         case "my_spaces":
            //           print(value);
            //           reader.getUserSpaces();
            //           break;
            //         default:
            //           print("All Spaces");
            //       }
            //     },
            //     radioButtons: const [
            //       {
            //         'icon': 'assets/images/community.png',
            //         'title': 'All Spaces',
            //         'value': 'all_spaces'
            //       },
            //       {
            //         'icon': 'assets/images/discord.png',
            //         'title': 'My Spaces',
            //         'value': 'my_spaces'
            //       },
            //     ],
            //   ),
            // ),
            const Gap(20),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list_rounded)
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.white,
                      decoration: primaryTextFieldWithPrefixIconDecoration(
                          labelText: "Search spaces",
                          prefixIcon: "assets/images/search.png"
                      ),
                    ),
                  ),
                ),
              ],
            ),
        

            const Gap(20),
            Expanded(
                child: notifier.viewState.isLoading
                    ? Center(child: CircularProgressIndicator(strokeWidth: 3, color: accentColor))
                    : notifier.viewState.isError
                    ? Center(child: Text(notifier.error))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        itemCount: notifier.spaces?.length,
                        itemBuilder: (context, index) {
                          final singleSpace = notifier.spaces?[index];
                          return SpaceCard(space: singleSpace!);
                        }
                )
            )
          ],
        ),
      )
    );
  }
}
