import 'dart:ffi';

import 'package:audaxious/core/routes/app_router.dart';
import 'package:audaxious/core/services/shared_preferences_services.dart';
import 'package:audaxious/domain/enums/button_state.dart';
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/screens/auth/sign_in_options_screen.dart';
import 'package:audaxious/presentation/viewmodels/account/account_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_outline_button.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_text_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../widgets/vertical_bar.dart';


@RoutePage()
class AccountScreen extends HookConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reader = ref.read(AccountViewModel.notifier.notifier);
    final notifier = ref.watch(AccountViewModel.notifier);
    final isLoggedIn = useState<bool?>(null);

    void fetchLoginStatus() async {
      await Future.delayed(const Duration(milliseconds: 100));
      isLoggedIn.value = await SharedPreferencesServices.getIsLoggedIn();
    }

    useEffect(() {
      fetchLoginStatus();
      return null;
    });

    return isLoggedIn.value == true
        ? Scaffold(
        appBar: AppBar(
          title: Text(
            "Account",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const Gap(20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.6, color: cardBorderColor),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: spacesCardColor
                  ),
                  child: Row(
                    children: [
                      ClipOval(
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl:  "https://res.cloudinary.com/dpm6velwz/image/upload/v1712005871/icon/660b22ef0bf929b3467fe78c.jpg",
                            placeholder: (context, url) => const CircularProgressIndicator(
                              color: Color(0xFF79C4EC),
                              strokeWidth: 2,
                            ),
                            width: profileImageWidth,
                            height: profileImageHeight,
                          )
                      ),
                      const Gap(15),
                      Expanded(
                        child: Text(
                          "HackCity Tech",
                          style: Theme.of(context).textTheme.displaySmall?.
                          copyWith(fontSize: 16, color: cardTitleColor),
                        ),
                      ),
                      const Gap(20),
                      SizedBox(
                          width: 80,
                          height: 35,
                          child: PrimaryOutlineButton(
                            borderRadius: 5,
                            borderColor: secondaryColor.withOpacity(0.3),
                            buttonText: "Edit",
                            onPressed: () {},
                          )
                      )
                    ],
                  ),
                ),
                const Gap(40),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.6, color: cardBorderColor),
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            color: spacesCardColor
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                VerticalBar(),
                                const Gap(20),
                                Text(
                                    "Loyalty point",
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: fadedTextColor)
                                )
                              ],
                            ),
                            const Gap(2),
                            Container(
                              margin: const EdgeInsets.only(left: 22),
                              child: Text(
                                "5000.00 XP",
                                style: Theme.of(context).textTheme.displaySmall?.
                                copyWith(fontSize: 16, color: cardTitleColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Gap(20),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.6, color: cardBorderColor),
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            color: spacesCardColor
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                VerticalBar(color: yellowBarColor,),
                                const Gap(20),
                                Text(
                                    "ADX Airdrop",
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: fadedTextColor)
                                )
                              ],
                            ),
                            const Gap(2),
                            Container(
                              margin: const EdgeInsets.only(left: 22),
                              child: Text(
                                "400.00 ADX",
                                style: Theme.of(context).textTheme.displaySmall?.
                                copyWith(fontSize: 16, color: cardTitleColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(25),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.6, color: cardBorderColor),
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            color: spacesCardColor
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                VerticalBar(color: purpleBarColor,),
                                const Gap(20),
                                Text(
                                    "Total rewards",
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: fadedTextColor)
                                )
                              ],
                            ),
                            const Gap(2),
                            Container(
                              margin: const EdgeInsets.only(left: 22),
                              child: Text(
                                "12,000.00 XP",
                                style: Theme.of(context).textTheme.displaySmall?.
                                copyWith(fontSize: 16, color: cardTitleColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Gap(20),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.6, color: cardBorderColor),
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            color: spacesCardColor
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                VerticalBar(color: greenBarColor,),
                                const Gap(20),
                                Text(
                                    "Available balance",
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: fadedTextColor)
                                )
                              ],
                            ),
                            const Gap(2),
                            Container(
                              margin: const EdgeInsets.only(left: 22),
                              child: Text(
                                "8,420.00 XP",
                                style: Theme.of(context).textTheme.displaySmall?.
                                copyWith(fontSize: 16, color: cardTitleColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(40),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.6, color: cardBorderColor),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: spacesCardColor
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(100)),
                              color: secondaryColor.withOpacity(0.1),
                            ),
                            child: Image.asset("assets/images/database.png", width: 20, height: 20,),
                          ),
                          const Gap(10),
                          Expanded(
                            child: Text(
                              "Tokens",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          SizedBox(
                              width: 150,
                              height: 35,
                              child: PrimaryOutlineButton(
                                borderRadius: 5,
                                borderColor: secondaryColor.withOpacity(0.3),
                                buttonText: "Claim reward",
                                onPressed: () {},
                              )
                          )

                        ],
                      ),
                      const Gap(25),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.6, color: cardBorderColor),
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  color: spacesCardColor
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset("assets/images/teterium.png", width: 30, height: 30),                              const Gap(7),
                                  const Gap(2),
                                  Text(
                                      "USDT",
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: fadedTextColor)
                                  ),
                                  const Gap(2),
                                  Text(
                                    "187.5234",
                                    style: Theme.of(context).textTheme.displaySmall?.
                                    copyWith(fontSize: 16, color: cardTitleColor),
                                  ),
                                  const Gap(5),
                                  Row(
                                    children: [
                                      Text(
                                          "-0.89%",
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: darkOrange, fontSize: 12)
                                      ),
                                      const Gap(5),
                                      Text(
                                          "\$3,491.17",
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: fadedTextColor, fontSize: 12)
                                      ),

                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Gap(20),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.6, color: cardBorderColor),
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  color: spacesCardColor
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset("assets/images/ether.png", width: 30, height: 30),                              const Gap(7),
                                  const Gap(2),
                                  Text(
                                      "ETHER",
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: fadedTextColor)
                                  ),
                                  const Gap(2),
                                  Text(
                                    "187.54",
                                    style: Theme.of(context).textTheme.displaySmall?.
                                    copyWith(fontSize: 16, color: cardTitleColor),
                                  ),
                                  const Gap(5),
                                  Row(
                                    children: [
                                      Text(
                                          "-0.89%",
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: darkOrange, fontSize: 12)
                                      ),
                                      const Gap(5),
                                      Text(
                                          "\$3,491.17",
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: fadedTextColor, fontSize: 12)
                                      ),

                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                      const Gap(25),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.6, color: cardBorderColor),
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  color: spacesCardColor
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset("assets/images/bnn.png", width: 30, height: 30),                              const Gap(7),
                                  Text(
                                      "BNB",
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: fadedTextColor)
                                  ),
                                  const Gap(5),
                                  Text(
                                    "0.5054",
                                    style: Theme.of(context).textTheme.displaySmall?.
                                    copyWith(fontSize: 16, color: cardTitleColor),
                                  ),
                                  const Gap(5),
                                  Row(
                                    children: [
                                      Text(
                                          "+0.89%",
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: successColor, fontSize: 12)
                                      ),
                                      const Gap(5),
                                      Text(
                                          "\$3,491.17",
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: fadedTextColor, fontSize: 12)
                                      ),

                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Gap(20),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.6, color: cardBorderColor),
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  color: spacesCardColor
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset("assets/images/adx.png", width: 30, height: 30),
                                  const Gap(7),
                                  Text(
                                      "ADX",
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: fadedTextColor)
                                  ),
                                  Text(
                                    "187.54",
                                    style: Theme.of(context).textTheme.displaySmall?.
                                    copyWith(fontSize: 16, color: cardTitleColor),
                                  ),
                                  const Gap(5),
                                  Row(
                                    children: [
                                      Text(
                                          "-0.89%",
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: darkOrange, fontSize: 12)
                                      ),
                                      const Gap(5),
                                      Text(
                                          "\$3,491.17",
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: fadedTextColor, fontSize: 12)
                                      ),

                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(40),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.6, color: cardBorderColor),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: spacesCardColor
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(100)),
                              color: secondaryColor.withOpacity(0.1),
                            ),
                            child: Image.asset("assets/images/wallet.png", width: 20, height: 20,),
                          ),
                          const Gap(10),
                          Expanded(
                            child: Text(
                              "Wallet details",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          SizedBox(
                              width: 150,
                              height: 35,
                              child: PrimaryOutlineButton(
                                borderRadius: 5,
                                borderColor: secondaryColor.withOpacity(0.3),
                                buttonText: "Bind wallet",
                                onPressed: () {},
                              )
                          )

                        ],
                      ),
                      const Gap(25),
                      Container(
                        padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.6, color: cardBorderColor),
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            color: spacesCardColor
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "0x7442bfe...db1a9",
                                style: Theme.of(context).textTheme.displaySmall?.
                                copyWith(fontSize: 16, color: fadedTextColor),
                              ),
                            ),
                            const Gap(20),
                            IconButton(
                              onPressed: (){},
                              icon: Image.asset("assets/images/copy.png", width: 16),
                              iconSize: 16,
                            ),
                            IconButton(
                              onPressed: (){},
                              icon: Image.asset("assets/images/delete.png", width: 16),
                              iconSize: 18,
                            ),
                          ],
                        ),
                      ),
                      const Gap(15),
                      Container(
                        padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.6, color: cardBorderColor),
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            color: spacesCardColor
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "0x7442bfe...db1a9",
                                style: Theme.of(context).textTheme.displaySmall?.
                                copyWith(fontSize: 16, color: fadedTextColor),
                              ),
                            ),
                            const Gap(20),
                            IconButton(
                              onPressed: (){},
                              icon: Image.asset("assets/images/copy.png", width: 16),
                              iconSize: 16,
                            ),
                            IconButton(
                              onPressed: (){},
                              icon: Image.asset("assets/images/delete.png", width: 16),
                              iconSize: 18,
                            ),
                          ],
                        ),
                      ),
                      const Gap(15),
                      Container(
                        padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.6, color: cardBorderColor),
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            color: spacesCardColor
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "0x7442bfe...db1a9",
                                style: Theme.of(context).textTheme.displaySmall?.
                                copyWith(fontSize: 16, color: fadedTextColor),
                              ),
                            ),
                            const Gap(20),
                            IconButton(
                              onPressed: (){},
                              icon: Image.asset("assets/images/copy.png", width: 16),
                              iconSize: 16,
                            ),
                            IconButton(
                              onPressed: (){},
                              icon: Image.asset("assets/images/delete.png", width: 16),
                              iconSize: 18,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                PrimaryTextButton(
                  buttonText: "Logout",
                  textColor: errorColor,
                  onPressed: () async {
                    bool isSuccessful = await reader.logoutUser();
                    if (isSuccessful) {
                      if (!context.mounted) return;
                      context.router.replaceAll([LoginRoute()]);
                    }
                  },
                  buttonState: notifier.logoutViewState.isLoading
                      ? ButtonState.loading
                      : ButtonState.active,
                ),
                const Gap(20),
              ],
            ),
          ),
        )
    )
        : const SignInOptionsScreen();
  }

}
