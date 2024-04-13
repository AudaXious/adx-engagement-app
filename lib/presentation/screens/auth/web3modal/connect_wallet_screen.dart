import 'package:audaxious/presentation/widgets/buttons/primary_button.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

@RoutePage()
class ConnectWalletScreen extends StatefulWidget {
  const ConnectWalletScreen({super.key});

  @override
  State<ConnectWalletScreen> createState() => _ConnectWalletScreenState();
}

class _ConnectWalletScreenState extends State<ConnectWalletScreen> {
  late W3MService _w3mService;

  @override
  void initState() {
    super.initState();
    initializeState();
    getAccountDetails();
    // print("${ _w3mService.getApprovedChains()}");
  }

  void initializeState() async {
    _w3mService = W3MService(
      projectId: '70630571fe8c62c8b5dfffe48ebc8c79',
      metadata: const PairingMetadata(
        name: 'Audaxious',
        description: 'Web3Modal Flutter Example',
        url: 'https://www.walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
        redirect: Redirect(
          native: 'audaxious://',
          universal: 'https://www.walletconnect.com',
        ),
      ),
    );

    await _w3mService.init();
  }

  void getAccountDetails() {
    print("Status: ${_w3mService.status}");
    print("Selected Wallet: ${_w3mService.selectedWallet}");
  }

  @override
  Widget build(BuildContext context) {
    getAccountDetails();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign In with Wallet",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              W3MConnectWalletButton(service: _w3mService),
              // W3MConnectWalletButton(
              //   service: _w3mService,
              //   state: ConnectButtonState.none,
              // ),
              const Gap(20),
              W3MNetworkSelectButton(service: _w3mService),
              const Gap(20),
              W3MAccountButton(service: _w3mService),
              const Gap(50),
              PrimaryButton(
                buttonText: "Sign in",
                onPressed: () {
                  getAccountDetails();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
