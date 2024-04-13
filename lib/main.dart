import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3modal_flutter/theme/w3m_theme_widget.dart';
import 'core/routes/app_router.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return Web3ModalTheme(
      isDarkMode: true,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'EduCarts',
        theme: darkTheme,
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
