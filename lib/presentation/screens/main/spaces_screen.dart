
import 'package:audaxious/core/routes/app_router.dart';
import 'package:audaxious/core/utils/view_utils.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/viewmodels/spaces/spaces_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/custom_radio_group_tabs_horizontal.dart';
import 'package:audaxious/presentation/widgets/cards/space_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utils/theme/dark_theme.dart';

@RoutePage()
class SpacesScreen extends HookConsumerWidget {
  SpacesScreen({super.key});

  final List<String> spacesCategories = [
    'All spaces',
    'My spaces',
    'Joined Spaces',
  ];
  // String? selectedSpacesCategory = null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reader = ref.read(SpacesViewModel.notifier.notifier);
    final notifier = ref.watch(SpacesViewModel.notifier);
    final selectedSpacesCategory = useState<String?>(null);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Spaces",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        centerTitle: true,
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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(Icons.filter_list_rounded)
                  // ),
                  // Image.asset("assets/images/menu_filter.png", height: 20, width: 20,),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'All spaces',
                          style: Theme.of(context).textTheme.bodyLarge
                        ),
                        items: spacesCategories
                            .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: Theme.of(context).textTheme.bodyLarge
                          ),
                        ))
                            .toList(),
                        value: selectedSpacesCategory.value,
                        onChanged: (String? value) {
                          selectedSpacesCategory.value = value;
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 120,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.white,
                      decoration: primaryTextFieldWithPrefixIconDecoration(
                          labelText: "Search spaces",
                          prefixIcon: "assets/images/search.png"
                      ),
                    ),
                  ),
                ],
              ),
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
