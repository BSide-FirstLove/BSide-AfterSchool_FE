import 'package:after_school/model/api/Login.dart';
import 'package:after_school/model/api/ModelResponse.dart';
import 'package:after_school/model/state.dart';
import 'package:after_school/resources/Theme.dart';
import 'package:after_school/screen/home_screen.dart';
import 'package:after_school/screen/login/login_screen.dart';
import 'package:after_school/util/MyHttp.dart';
import 'package:after_school/util/MyScreenUtil.dart';
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
        child: MaterialApp(
          theme: myThemeData(),
          // home: MyApp(),
          initialRoute: "/",
          routes: {
            '/':(_) => const MyApp(),
            // '/search': (_) => {},
            '/login': (_) => const LoginScreen(),
            '/main': (_) => const HomeScreen(),
          },
        ),
      )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyappState();
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
    bool isLogin = false;
    if (await AuthApi.instance.hasToken()) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        AccessTokenInfo tokenInfo =
        await UserApi.instance.accessTokenInfo();
        print('토큰 유효성 체크 성공 $tokenInfo');
        String? kakaoToken = prefs.getString('kakaoToken');
        if(kakaoToken != null){
          print(kakaoToken);
          MyHttp().setKakaoToken(kakaoToken);
          // Login modelLogin = await MyHttp().login(LoginReq(accessToken: kakaoToken));
          // if(!modelLogin.isNewMember) {
          //   isLogin = true;
          // }
        }
      } catch (error) {
        if (error is KakaoException && error.isInvalidTokenError()) {
          print('토큰 만료 $error');
        } else {
          print('토큰 정보 조회 실패 $error');
        }
      }
    }
    Future.delayed(
        const Duration(seconds: 4),
        () => Navigator.pushReplacementNamed(
              context,
              isLogin? '/main' : '/login'),
            );
  }

  // Future<Login> _login(String token) async {
  //   ModelResponse responseBody = await MyHttp().post(context, 'auth/kakao', {'accessToken': token});
  //   return Login.fromJson(responseBody.data);
  // }

  @override
  Widget build(BuildContext context) {
    MyScreenUtil.init(context: context, designSize: const Size(360, 640));
    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset("assets/images/splash.gif",
                gaplessPlayback: true, fit: BoxFit.fill)));
  }
}
