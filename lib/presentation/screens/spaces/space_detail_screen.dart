import 'dart:ffi';

import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/viewmodels/spaces/space_detail_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_button.dart';
import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/theme/dark_theme.dart';

@RoutePage()
class SpaceDetailScreen extends HookConsumerWidget {
  String spaceId;
  SpaceDetailScreen({super.key, required this.spaceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reader = ref.read(SpacesDetailsViewModel.notifier.notifier);
    final notifier = ref.watch(SpacesDetailsViewModel.notifier);

    final coverUrl = useState<String?>(null);
    final profileUrl = useState<String?>(null);
    final title = useState<String?>(null);
    final description = useState<String?>(null);

    coverUrl.value = notifier.spaceDetails?.coverURL;
    profileUrl.value = notifier.spaceDetails?.profileURL;
    title.value = notifier.spaceDetails?.title;
    description.value = notifier.spaceDetails?.description;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Space",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                reader.getSpaceDetail(spaceId);
              },
              icon: Icon(Icons.refresh)
          )
        ],
      ),
      body: notifier.viewState.isLoading
          ? Center(child: CircularProgressIndicator(strokeWidth: 3, color: accentColor))
          : notifier.viewState.isError
          ? Center(child: Text(notifier.error),)
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        child: coverUrl.value == null
                          ? Container(
                              width: double.infinity,
                              height: coverImageHeight,
                              color: Colors.grey,
                            )
                          : CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: coverUrl.value ?? "",
                              width: double.infinity,
                              height: coverImageHeight,
                            ),
                      ),
                      
                      Positioned(
                        top: coverImageHeight - profileImageHeight / 2,
                        left: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2)
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: profileImageHeight/2,
                            child: profileUrl.value == null
                                ? Image.asset("assets/images/dumm_profile.png", width: profileImageHeight, height: profileImageHeight,)
                                : CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: profileUrl.value ?? "",
                                    width: profileImageHeight,
                                    height: profileImageHeight,
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title.value ?? "",
                                    style: Theme.of(context).textTheme.displayMedium,
                                  ),
                                  const Gap(3),
                                  Text(
                                    "0 active campaign",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: lightGreen),
                                  )
                                ],
                              ),
                            ),
                            const Gap(50),
                            SizedBox(
                              width: 120,
                              height: 32,
                              child: PrimaryButton(
                                  onPressed: () {},
                                  buttonText: "Join space",
                                  borderRadius: 30
                              )
                            )
                          ],
                        ),
                        const Gap(20),
                        Text(
                            description.value ?? "",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: greyTextColor)
                        )
                      ],
                    ),
                  )
                ],
              ),
      )
    );
  }
}
