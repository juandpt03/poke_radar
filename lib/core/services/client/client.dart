import 'package:dio/dio.dart';
import 'package:poke_radar/core/core.dart';

class Client {
  static final Dio client = Dio(
    BaseOptions(
      baseUrl: Environment().baseUrl,
      contentType: 'application/json',
    ),
  );

  Client._internal();

  static final Client _instance = Client._internal();

  factory Client() => _instance;
}
