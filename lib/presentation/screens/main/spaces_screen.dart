
import 'package:audaxious/core/services/shared_preferences_services.dart';
import 'package:audaxious/core/utils/view_utils.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/viewmodels/spaces/spaces_viewmodel.dart';
import 'package:audaxious/presentation/widgets/cards/space_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/space.dart';
import '../../widgets/alerts/empty_result_found_illustration.dart';
import '../../widgets/alerts/sign_in_dialog.dart';

@RoutePage()
class SpacesScreen extends HookConsumerWidget {
  SpacesScreen({super.key});

  final List<String> spacesCategories = [
    'All spaces',
    'My spaces',
    'Joined spaces',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reader = ref.read(SpacesViewModel.notifier.notifier);
    final notifier = ref.watch(SpacesViewModel.notifier);
    final selectedSpacesCategory = useState<String?>(null);
    final List<Space>? spaces = notifier.spaces;
    final List<Space>? filteredSpaces = notifier.filteredSpaces;

    final List<Space>? displayedSpaces =
    filteredSpaces != null && filteredSpaces.isNotEmpty
        ? filteredSpaces
        : (filteredSpaces != null ? [] : spaces);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Spaces",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Gap(20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Row(
                  children: [
                    Image.asset("assets/images/menu_filter.png", width: 20, height: 20),
                    DropdownButtonHideUnderline(
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
                        onChanged: (String? value) async {
                          final isLoggedIn = await SharedPreferencesServices.getIsLoggedIn();
                          selectedSpacesCategory.value = value;

                          switch (selectedSpacesCategory.value) {
                            case "All spaces":
                              reader.getSpaces();
                              break;
                            case "My spaces":
                              if (isLoggedIn) {
                                reader.getUserCreatedSpaces();
                                break;
                              }else {
                                if (!context.mounted) return;
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SignInDialog();
                                  },
                                );
                              }
                            case "Joined spaces":
                              if (isLoggedIn) {
                                reader.getUserJoinedSpaces();
                                break;
                              }else {
                                if (!context.mounted) return;
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SignInDialog();
                                  },
                                );
                              }

                            default:
                              reader.getSpaces();
                              break;
                          }
                          },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 145,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        iconStyleData: IconStyleData(
                            icon: Image.asset("assets/images/arrow_down.png")
                        ),

                      ),
                    )
                  ],
                ),
                const Gap(10),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.white,
                      decoration: primaryTextFieldWithPrefixIconDecoration(
                          hintText: "Search spaces",
                          prefixIcon: "assets/images/search.png"
                      ),
                      onChanged: (query) {
                        reader.filterSpacesByTitle(query);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),
          Expanded(
              child: notifier.spaceViewState.isLoading
                  ? const Center(child: CircularProgressIndicator(strokeWidth: 3))
                  : notifier.spaceViewState.isError
                  ? Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(notifier.error, textAlign: TextAlign.center,),
                  )
              )
                  : displayedSpaces!.isEmpty
                  ? NoResultFoundIllustration(
                title: "No spaces to show",
                description: "Spaces you join or create will appear here",
                illustration: "assets/images/empty_spaces_cards.png",
              )
                  : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  itemCount: displayedSpaces.length,
                  itemBuilder: (context, index) {
                    final singleSpace = displayedSpaces[index];
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SpaceCard(space: singleSpace)
                    );
                  }
              )

          )
        ],
      )
    );
  }
}
