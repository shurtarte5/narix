import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../mappers/auth_mapper.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required SecureStorage storage,
  })  : _remote = remoteDataSource,
        _storage = storage,
        _mapper = const AuthMapper();

  final AuthRemoteDataSource _remote;
  final SecureStorage _storage;
  final AuthMapper _mapper;

  @override
  Future<Result<UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final tokenDto = await _remote.login(email: email, password: password);
      await _storage.saveToken(tokenDto.accessToken);
      // Decode basic user info from token or re-fetch — for now we build
      // a minimal entity from what we have post-login.
      // A dedicated /auth/me endpoint can enrich this later.
      return Success(UserEntity(id: '', email: email, fullName: '', role: UserRole.owner));
    } on DioException catch (e) {
      final message = _parseDioError(e);
      return Failure(message);
    } catch (_) {
      return const Failure('Error inesperado. Intenta de nuevo.');
    }
  }

  @override
  Future<Result<UserEntity>> register({
    required String email,
    required String fullName,
    required String password,
    required UserRole role,
  }) async {
    try {
      final userDto = await _remote.register(
        email: email,
        fullName: fullName,
        password: password,
        role: role.name,
      );
      return Success(_mapper.toEntity(userDto));
    } on DioException catch (e) {
      final message = _parseDioError(e);
      return Failure(message);
    } catch (_) {
      return const Failure('Error inesperado. Intenta de nuevo.');
    }
  }

  String _parseDioError(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['detail'] != null) return data['detail'].toString();
    switch (e.response?.statusCode) {
      case 401:
        return 'Credenciales incorrectas.';
      case 409:
        return 'El correo ya está registrado.';
      default:
        return 'Error de conexión. Verifica tu red.';
    }
  }
}
