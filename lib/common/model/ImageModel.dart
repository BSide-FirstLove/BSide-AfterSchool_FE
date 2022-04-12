class ModelImageState {
  static const int KAKAO = 1;
  static const int BASIC = 2;
  static const int FILE = 3;
  static const int EDIT = 4;
  static const String basicImage = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmSqpNxariPV-GwKRmpqb41qBpdRlTeZu2Yd7KLIHXEW37I4Slcoc-HOHoYQowCWeNJA0&usqp=CAU';

  int type;
  dynamic image;

  ModelImageState({
    required this.type,
    required this.image,
  });
}