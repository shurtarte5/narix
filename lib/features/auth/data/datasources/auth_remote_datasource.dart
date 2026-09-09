import '../dtos/token_dto.dart';
import '../dtos/user_dto.dart';

abstract interface class AuthRemoteDataSource {
  Future<TokenDto> login({required String email, required String password});

  Future<UserDto> register({
    required String email,
    required String fullName,
    required String password,
    required String role,
  });
}
