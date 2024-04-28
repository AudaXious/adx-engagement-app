import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:audaxious/presentation/widgets/alerts/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
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
    return GlobalLoaderOverlay(
      overlayColor: backgroundColor,
      useDefaultLoading: false,
      disableBackButton: false,
      closeOnBackButton: true,
      overlayWidgetBuilder: (_) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Loading(message: "Please wait...",)
            ],
          ),
        );
      },
      child: Web3ModalTheme(
        isDarkMode: true,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'AudaXious',
          theme: darkTheme,
          routerConfig: _appRouter.config(),
        ),
      )
      ,
    );
  }
}

class ZoomableWidget extends StatefulWidget {
  final Widget child;

  const ZoomableWidget({super.key, required this.child});

  @override
  _ZoomableWidgetState createState() => _ZoomableWidgetState();
}

class _ZoomableWidgetState extends State<ZoomableWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.7 + 0.5 * _controller.value,
          child: widget.child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
