import 'package:dio/dio.dart';

import '../dtos/login_request_dto.dart';
import '../dtos/register_request_dto.dart';
import '../dtos/token_dto.dart';
import '../dtos/user_dto.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<TokenDto> login({required String email, required String password}) async {
    final response = await _dio.post(
      '/auth/login',
      data: LoginRequestDto(email: email, password: password).toJson(),
    );
    return TokenDto.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<UserDto> register({
    required String email,
    required String fullName,
    required String password,
    required String role,
  }) async {
    final response = await _dio.post(
      '/auth/register',
      data: RegisterRequestDto(
        email: email,
        fullName: fullName,
        password: password,
        role: role,
      ).toJson(),
    );
    return UserDto.fromJson(response.data as Map<String, dynamic>);
  }
}
