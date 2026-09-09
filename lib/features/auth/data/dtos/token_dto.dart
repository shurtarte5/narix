class TokenDto {
  const TokenDto({required this.accessToken, required this.tokenType});

  final String accessToken;
  final String tokenType;

  factory TokenDto.fromJson(Map<String, dynamic> json) => TokenDto(
        accessToken: json['access_token'] as String,
        tokenType: json['token_type'] as String,
      );
}
