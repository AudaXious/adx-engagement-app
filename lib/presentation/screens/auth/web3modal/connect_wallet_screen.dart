import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
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
  }

  void initializeState() async {
    _w3mService = W3MService(
      projectId: '70630571fe8c62c8b5dfffe48ebc8c79',
      metadata: const PairingMetadata(
        name: 'Web3Modal Flutter Example',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Wallet connect"),
    );
  }
}
