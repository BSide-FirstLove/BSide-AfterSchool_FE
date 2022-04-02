class Login {
  final bool isNewMember;
  final String nickName;
  // final String appToken;

  const Login({
    required this.isNewMember,
    required this.nickName,
    // required this.appToken,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      isNewMember: json['isNewMember'],
      nickName: json['nickname'],
      // appToken: json['appToken'],
    );
  }
}