import 'package:poke_radar/core/services/service_locator/service_locator.dart';
import 'package:poke_radar/core/utils/env_loader/env_loader.dart';

class Environment {
  static final Environment _instance = Environment._internal();
  static final EnvLoader _envLoader = ServiceLocator().get<EnvLoader>();

  Environment._internal();

  factory Environment() => _instance;

  final baseUrl = _envLoader.get('BASE_URL');
}
