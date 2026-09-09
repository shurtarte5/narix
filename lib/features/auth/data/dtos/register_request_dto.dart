class RegisterRequestDto {
  const RegisterRequestDto({
    required this.email,
    required this.fullName,
    required this.password,
    required this.role,
  });

  final String email;
  final String fullName;
  final String password;
  final String role;

  Map<String, dynamic> toJson() => {
        'email': email,
        'full_name': fullName,
        'password': password,
        'role': role,
      };
}
