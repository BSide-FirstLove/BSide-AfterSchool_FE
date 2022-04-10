class Join {
  final String? isNewMember;
  final String? nickname;
  final String? appToken;

  const Join({
    required this.isNewMember,
    required this.nickname,
    required this.appToken,
  });

  factory Join.fromJson(Map<String, dynamic> json) {
    return Join(
      isNewMember: json['isNewMember'],
      nickname: json['nickname'],
      appToken: json['appToken'],
    );
  }
}

class JoinReq {
  final String accessToken;
  final String placeId;
  final String enterYear;
  final String endYear;
  final String nickname;

  const JoinReq({
    required this.accessToken,
    required this.placeId,
    required this.enterYear,
    required this.endYear,
    required this.nickname
  });

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "placeId": placeId,
    "enterYear": enterYear,
    "endYear": endYear,
    "nickname": nickname
  };
}