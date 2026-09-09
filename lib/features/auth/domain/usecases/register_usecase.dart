import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  const RegisterUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<UserEntity>> call({
    required String email,
    required String fullName,
    required String password,
    required UserRole role,
  }) =>
      _repository.register(
        email: email,
        fullName: fullName,
        password: password,
        role: role,
      );
}
