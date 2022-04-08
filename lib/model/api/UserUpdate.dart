class UserUpdate {
  final int id;
  final String? name;
  final String? email;
  final String? gender;
  final String? socialId;
  final String? userProvider;
  final String? roleType;
  final String? schoolName;
  final String? enterYear;
  final String? endYear;
  final String? instagramUrl;
  final String? job;
  final String? description;
  final String? profileImagePath;

  const UserUpdate({
    required this.id, this.name, this.email,
    this.gender, this.socialId, this.userProvider,
    this.roleType, this.schoolName, this.enterYear,
    this.endYear, this.instagramUrl, this.job,
    this.description, this.profileImagePath
  });

  factory UserUpdate.fromJson(Map<String, dynamic> json) {
    return UserUpdate(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

class UserUpdateReq {
  final String instagramId;
  final String job;
  final String description;
  final String? profileImagePath;

  const UserUpdateReq({
    required this.instagramId,
    required this.job,
    required this.description,
    this.profileImagePath,
  });

  Map<String, dynamic> toJson() => {
    "instagramId": instagramId,
    "job": job,
    "description": description,
    "profileImagePath": profileImagePath
  };
}