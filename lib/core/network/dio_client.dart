import 'package:dio/dio.dart';
import 'auth_interceptor.dart';

// IP local de la Mac que corre el backend (misma red WiFi que el celular).
// 'localhost' no funciona desde un dispositivo físico: apunta al propio teléfono.
const _baseUrl = 'http://192.168.0.3:8000';

Dio buildDio(AuthInterceptor authInterceptor) {
  final dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );
  dio.interceptors.add(authInterceptor);
  return dio;
}
