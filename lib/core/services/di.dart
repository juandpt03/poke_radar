import 'package:poke_radar/core/core.dart';
import 'package:poke_radar/features/shared/shared.dart';

class DI {
  DI._internal();
  static final DI instance = DI._internal();
  static final ServiceLocator serviceLocator = ServiceLocator();

  factory DI() => instance;

  Future<void> setup() async {
    await EnvLoader().loadEnv('.env');

    serviceLocator.register(EnvLoader());
    serviceLocator.register(AppTheme());
    serviceLocator.register(TransitionManager());
    serviceLocator.register(ImageManager());
  }
}
