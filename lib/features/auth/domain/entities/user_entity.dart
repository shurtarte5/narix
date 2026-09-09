import 'package:equatable/equatable.dart';

enum UserRole { owner, vet }

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
  });

  final String id;
  final String email;
  final String fullName;
  final UserRole role;

  @override
  List<Object?> get props => [id, email, fullName, role];
}
