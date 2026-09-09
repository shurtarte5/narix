import '../../domain/entities/user_entity.dart';
import '../dtos/user_dto.dart';

class AuthMapper {
  const AuthMapper();

  UserEntity toEntity(UserDto dto) => UserEntity(
        id: dto.id,
        email: dto.email,
        fullName: dto.fullName,
        role: dto.role == 'owner' ? UserRole.owner : UserRole.vet,
      );
}
