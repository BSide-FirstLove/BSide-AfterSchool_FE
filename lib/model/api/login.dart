class Login {
  final bool isNewMember;
  final String nickname;
  final String? appToken;

  const Login({
    required this.isNewMember,
    required this.nickname,
    required this.appToken,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      isNewMember: json['isNewMember'],
      nickname: json['nickname'],
      appToken: json['appToken'],
    );
  }
}