import 'package:audaxious/core/routes/app_router.dart';
import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
class CreateCommunitySuccessScreen extends StatelessWidget {
  const CreateCommunitySuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/pink_star.png", height: 35, width: 35),
                  Image.asset("assets/images/telegram.png", height: 30, width: 30),
                ],
              ),
              const Gap(20),
              Text(
                "You are Now Live!",
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const Gap(5),
              Text(
                "Your community has created",
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              const Gap(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/green_star.png", height: 35, width: 35),
                  const Gap(50),
                  Image.asset("assets/images/binance_coin.png", height: 30, width: 30),
                ],
              ),
              const Gap(20),
              Image.asset("assets/images/purple_buble_check.png", height: 150, width: 150),
              const Gap(20),
              Text(
                "Share your links to have members join and engage to the fullest.",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12, color: fadedTextColor),
                textAlign: TextAlign.center,
              ),
              const Gap(20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: cardBorderColor, width: 1)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "https://www.audaxious.com/",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: fadedTextColor),
                    ),
                    TextButton(
                        onPressed: (){},
                        child: Text(
                          "Copy",
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                    )
                  ],
                ),
              ),
              const Gap(50),
              PrimaryButton(
                onPressed: (){
                  context.router.replaceAll([const CommunityRoute()]);
                },
                buttonText: "My communities"
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
