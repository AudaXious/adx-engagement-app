
import 'package:audaxious/core/routes/app_router.dart';
import 'package:audaxious/core/utils/view_utils.dart';
import 'package:audaxious/presentation/widgets/buttons/custom_radio_group_tabs_horizontal.dart';
import 'package:audaxious/presentation/widgets/cards/community_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

@RoutePage()
class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Community",
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
      body: Column(
        children: [
          const Gap(20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomRadioGroupTabsHorizontal(
              onValueChanged: (value) {
                setState(() {
                  print("Selected community type: $value");
                });
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
      ),
    );
  }
}
