import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:web3modal_flutter/services/w3m_service/i_w3m_service.dart';
import 'package:web3modal_flutter/services/w3m_service/w3m_service.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

@RoutePage()
class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late W3MService _w3mService;

  @override
  void initState() {
    super.initState();
    initializeW3MService();
  }

  // @override
  // void didUpdateWidget(covariant FirstScreen oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  void didUpdateWidget(covariant FirstScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("Hello");
    // _state = widget.state ?? ConnectButtonState.idle;
    // _updateState();
  }

  void loginUser() async {
    print("Login started");

    if (_w3mService != null) {
      final walletId = _w3mService.session?.address;
      print("Wallert address: $walletId");

      // if (walletId != null) {
      //   final user = await reader.loginUser(walletId);
      //   if (user == null) {
      //     if (!context.mounted) return;
      //     CustomToast.show(
      //       context: context,
      //       title: "Error",
      //       description: "Failed to login user. Please try again!",
      //       type: ToastificationType.error,
      //     );
      //
      //   }else {
      //     if (user.username == null) {
      //       if (!context.mounted) return;
      //       print("User name does not exists ${user.username}");
      //       // context.router.navigate(CreateUsernameRoute());
      //     }else {
      //       if (!context.mounted) return;
      //       print("User name exists ${user.username}");
      //       // context.router.replaceAll([const BottomBarRoute()]);
      //     }
      //   }
      //
      // }else {
      // }

    }
  }

  void initializeW3MService() async {
    print("Initialization started");

    _w3mService = W3MService(
      projectId: '70630571fe8c62c8b5dfffe48ebc8c79',
      metadata: const PairingMetadata(
        name: 'Audaxious',
        description: 'Connect wallet to AudaXious',
        url: 'https://www.audaxious.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
        redirect: Redirect(
          native: 'audaxious://',
          universal: 'https://www.walletconnect.com',
        ),
      ),
    );

    await _w3mService.init();
    if (_w3mService.status == W3MServiceStatus.initialized) {
      loginUser();
    }

    // print("Wallet addressxyz ${_w3mService.session!.address!}");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Wallet address ${_w3mService.session?.address}"),
          ElevatedButton(
              onPressed: (){
                _w3mService.openModal(context);
              },
              child: const Text("Connect Wallet")
          )
        ],
      ),
    );
  }
}
