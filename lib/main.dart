import 'package:after_school/model/state.dart';
import 'package:after_school/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  KakaoSdk.init(nativeAppKey: dotenv.get('KAKAO_NATIVE_APP_KEY'));
  runApp(
      ChangeNotifierProvider(
        create: (context) => UserState(),
        child: const MaterialApp(
          home: MyApp(),
        ),
      )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    //  build 이후 실행
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => _checkLogin());
  }

  _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = false;
    if (await AuthApi.instance.hasToken()) {
      try {
        AccessTokenInfo tokenInfo =
        await UserApi.instance.accessTokenInfo();
        print('토큰 유효성 체크 성공 $tokenInfo');
        String? kakaoToken = prefs.getString('kakaoToken');
        if(kakaoToken != null){
          print(kakaoToken);
          isLogin = true;
        } else {
          isLogin = false;
        }
      } catch (error) {
        if (error is KakaoException && error.isInvalidTokenError()) {
          print('토큰 만료 $error');
        } else {
          print('토큰 정보 조회 실패 $error');
        }
        isLogin = false;
      }
    } else {
      isLogin = false;
    }
    Future.delayed(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen(isLogin: isLogin)),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset("assets/images/splash.gif",
                gaplessPlayback: true, fit: BoxFit.fill)));
  }
}
