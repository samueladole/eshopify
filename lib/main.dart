import 'package:flutter/material.dart';
import 'core/router/app_router.dart';
import 'core/state/app_state.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EshopifyApp());
}

class EshopifyApp extends StatefulWidget {
  const EshopifyApp({super.key});
  @override State<EshopifyApp> createState() => _EshopifyAppState();
}

class _EshopifyAppState extends State<EshopifyApp> {
  final _state = AppState();
  late final _router = createRouter();

  @override Widget build(BuildContext context) {
    return AppStateScope(
      notifier: _state,
      child: AnimatedBuilder(
        animation: _state,
        builder: (context, _) => MaterialApp.router(
          title: 'Eshopify',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: _state.themeMode,
          routerConfig: _router,
        ),
      ),
    );
  }
}
