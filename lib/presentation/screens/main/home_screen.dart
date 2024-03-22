import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/viewmodels/home/home_viewmodel.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utils/view_utils.dart';
import '../../widgets/cards/campaign_card.dart';
import '../../widgets/empty_result_found_illustration.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  HomeScreen({super.key});

  final List<String> spacesCategories = [
    'All',
    'New',
    'Old',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reader = ref.read(HomeViewModel.notifier.notifier);
    final notifier = ref.watch(HomeViewModel.notifier);
    final selectedSpacesCategory = useState<String?>(null);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Campaigns",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              iconSize: 20,
              onPressed: (){},
              icon: const Icon(Icons.notifications_outlined)
          )
        ],
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
                            'All',
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
                          switch (selectedSpacesCategory.value) {
                            case "All":
                              reader.getCampaigns();
                              break;
                            case "New":
                              reader.getCampaigns();
                              break;
                            case "Old":
                              reader.getCampaigns();
                              break;

                            default:
                              reader.getCampaigns();
                              break;
                          }
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 80,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        iconStyleData: IconStyleData(
                          icon: Image.asset("assets/images/arrow_down.png")
                        ),
                      ),
                    ),
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
                          hintText: "Search campaigns",
                          prefixIcon: "assets/images/search.png"
                      ),
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
                ? Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(notifier.error, textAlign: TextAlign.center,),
                )
            )
                : notifier.campaigns!.isEmpty
                ? NoResultFoundIllustration(
              title: "No campaigns to show",
              description: "Campaigns you join or create will appear here",
              illustration: "assets/images/empty_spaces_cards.png",
            )
                : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: notifier.campaigns?.length,
                itemBuilder: (context, index) {
                  final singleFeed = notifier.campaigns?[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CampaignCard(
                      campaign: singleFeed!,
                      postIndex: index,
                    ),
                  );
                }
            ),

          )
        ],
      )
    );
  }
}
