import 'package:poke_radar/core/core.dart';
import 'package:poke_radar/features/home/presentation/screens/home_screen.dart';
import 'package:poke_radar/features/shared/shared.dart';
import 'package:poke_radar/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final transition = ServiceLocator().get<TransitionManager>();
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: SplashScreen.routeName,
        pageBuilder: (context, state) => transition.slideTransition(
          child: const SplashScreen(),
          state: state,
        ),
        name: SplashScreen.routeName,
      ),
      GoRoute(
        path: HomeScreen.routeName,
        pageBuilder: (context, state) => transition.slideTransition(
          child: const HomeScreen(),
          state: state,
        ),
        name: HomeScreen.routeName,
      )
    ],
  );
});
