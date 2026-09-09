import 'package:dio/dio.dart';
import 'auth_interceptor.dart';

const _baseUrl = 'http://localhost:8000';

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
