import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required SecureStorage storage,
  })  : _login = loginUseCase,
        _register = registerUseCase,
        _storage = storage,
        super(const AuthInitial());

  final LoginUseCase _login;
  final RegisterUseCase _register;
  final SecureStorage _storage;

  Future<void> checkAuth() async {
    try {
      final token = await _storage.readToken();
      if (token != null) {
        emit(const AuthAuthenticated(
          UserEntity(id: '', email: '', fullName: '', role: UserRole.owner),
        ));
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (_) {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(const AuthLoading());
    final result = await _login(email: email, password: password);
    switch (result) {
      case Success(:final data):
        emit(AuthAuthenticated(data));
      case Failure(:final message):
        emit(AuthError(message));
    }
  }

  Future<void> register({
    required String email,
    required String fullName,
    required String password,
    required UserRole role,
  }) async {
    emit(const AuthLoading());
    final result = await _register(
      email: email,
      fullName: fullName,
      password: password,
      role: role,
    );
    switch (result) {
      case Success():
        emit(const AuthUnauthenticated()); // navega a login tras registro
      case Failure(:final message):
        emit(AuthError(message));
    }
  }

  Future<void> logout() async {
    await _storage.deleteToken();
    emit(const AuthUnauthenticated());
  }
}
