import 'package:poke_radar/core/config/router/app_router.dart';
import 'package:poke_radar/core/core.dart';
import 'package:poke_radar/features/shared/presentation/providers/observers/logger_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final di = DI();

  await di.setup();
  runApp(
    ProviderScope(
      observers: [ProviderStateLogger()],
      child: MultiObserver(
        observers: [
          (context, child) => LanguageObserver(child: child),
        ],
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sl = ServiceLocator();
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      themeMode: ThemeMode.system,
      theme: sl.get<AppTheme>().lightTheme,
      darkTheme: sl.get<AppTheme>().darkTheme,
      routerConfig: router,
    );
  }
}
