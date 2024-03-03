import 'dart:typed_data';

import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:audaxious/presentation/screens/main/community/create_community_success_screen.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/view_utils.dart';

@RoutePage()
class CreateCommunityScreen extends StatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  State<CreateCommunityScreen> createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends State<CreateCommunityScreen> {
  @override
  Widget build(BuildContext context) {
    Uint8List? _image;
    List<String> tags = [];
    List<String> options = [
      '#Defi', '#Games', '#NFT',
      '#Web3', '#AI', '#Blockchain',
    ];

    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Create a Community",
            style: Theme.of(context).textTheme.displaySmall,
          )
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: bannerColor1
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Create, Invite, Connect and have fun",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    // const Gap(20),
                    // Container(
                    //   padding: const EdgeInsets.all(5),
                    //   decoration: BoxDecoration(
                    //     border: Border.all(width: 1.5, color: primaryColor),
                    //     borderRadius: const BorderRadius.all(Radius.circular(15)),
                    //   ),
                    //   child: Text(
                    //     "1/3",
                    //     style: Theme.of(context).textTheme.displayMedium?.
                    //     copyWith(fontSize: 10),
                    //   ),
                    // )
                  ],
                ),
              ),
              const Gap(40),
              Stack(
                children: [
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      // image: DecorationImage(
                      //   fit: BoxFit.cover,
                      //   image: AssetImage("assets/images/dummy_cover_photo.png")
                      // ),
                      color: primaryColor.withOpacity(0.85)
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                        },
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        ),
                        iconSize: 25,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -30,
                      child: Stack(
                        children: [
                          _image != null
                              ? SizedBox(
                            height: 60,
                            width: 60,
                            child: CircleAvatar(
                              radius: 100,
                              backgroundImage: MemoryImage(_image!),
                            ),
                          )
                              : const SizedBox(
                            height: 60,
                            width: 60,
                            child: CircleAvatar(
                              radius: 100,
                              backgroundImage: AssetImage("assets/images/dummy_profile.png"),
                            ),
                          ),
                          Positioned(
                              width: 60,
                              height: 60,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: bannerColor1,
                                ),
                              )),
                          Positioned(
                              width: 60,
                              height: 60,
                              child: IconButton(
                                onPressed: () {
                                },
                                icon: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                iconSize: 40,
                              )
                          )
                        ],
                      )
                  )
                ],
              ),
              const Gap(30),
              TextField(
                decoration: primaryTextFormFieldDecoration(labelText: 'Enter community name'),
              ),
              const Gap(20),
              TextField(
                keyboardType: TextInputType.multiline,
                minLines: 2,
                maxLines: 10,
                decoration: primaryTextFormFieldDecoration(labelText: 'Enter description'),
              ),
              const Gap(30),
              Text(
                "Select hastags #",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(),
              ),
              ChipsChoice<String>.multiple(
                value: tags,
                onChanged: (val) => setState(() => tags = val),
                choiceItems: C2Choice.listFrom<String, String>(
                  source: options,
                  value: (i, v) => v,
                  label: (i, v) => v,
                ),
              ),
              const Gap(20),
              const TextField(
                keyboardType: TextInputType.text,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  labelText: "Telegram",
                  prefixIcon: Icon(Icons.telegram)
                )
              ),
              const Gap(20),
              const TextField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      labelText: "Discord",
                      prefixIcon: Icon(Icons.discord)
                  )
              ),
              const Gap(20),
              const TextField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      labelText: "Website",
                      prefixIcon: Icon(Icons.link)
                  )
              ),
              const Gap(50),
              PrimaryButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                          builder: (context) => const CreateCommunitySuccessScreen(),
                          fullscreenDialog: true
                      )
                  );
                },
                buttonText: "Create my community"
              ),
              const Gap(50),
            ],
          ),
        ),
      ),
    );
  }
}
