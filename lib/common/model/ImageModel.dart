class ModelImageState {
  static const int KAKAO = 1;
  static const int BASIC = 2;
  static const int MEMORY = 3;
  static const String basicImage = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmSqpNxariPV-GwKRmpqb41qBpdRlTeZu2Yd7KLIHXEW37I4Slcoc-HOHoYQowCWeNJA0&usqp=CAU';

  int type;
  dynamic image;

  ModelImageState({
    required this.type,
    required this.image,
  });
}

// class ModelImageType {
//   final int kakao = 1;
//   final int basic = 2;
//   final int memory = 3;
//
//   const LoginReq({
//     required this.accessToken,
//   });
//
//   Map<String, dynamic> toJson() => {
//     "accessToken": accessToken
//   };
// }