import 'package:after_school/model/api/response.dart';
import 'package:after_school/model/state.dart';
import 'package:after_school/resources/MyTextStyle.dart';
import 'package:after_school/resources/Strings.dart';
import 'package:after_school/screen/add_name_screen.dart';
import 'package:after_school/util/my_http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';
import 'package:after_school/model/user.dart' as my_user;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/api/login.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  _kakaoLogin() async {
    // 카카오톡 설치 여부 확인
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공11');
        _loginSuccess(token.accessToken);
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {}
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공22');
          _loginSuccess(token.accessToken);
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공33');
        _loginSuccess(token.accessToken);
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  _loginSuccess(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('kakaoToken', token);
    await _getUser();

    MyHttp().setAuth(token);
    ModelResponse responseBody = await MyHttp().post(context, 'auth/kakao', {'accessToken': token});
    Login modelLogin = Login.fromJson(responseBody.data);
    if(modelLogin.isNewMember) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => AddNameScreen(nickname: modelLogin.nickname)));
    }else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    }
  }

  _getUser() async {
    try {
      User kakaoUser = await UserApi.instance.me();
      Provider.of<UserState>(context, listen: false).add(
      // context.watch<UserState>().add(
          my_user.User.fromKakao(kakaoUser)
      );
      print('사용자 정보 요청 성공'
          '\n토큰: ${kakaoUser.groupUserToken}'
          '\n회원번호: ${kakaoUser.id}'
          '\n이미지: ${kakaoUser.kakaoAccount?.profile?.profileImageUrl}'
          '\n이미지썸넬: ${kakaoUser.kakaoAccount?.profile?.thumbnailImageUrl}'
          '\n닉네임: ${kakaoUser.kakaoAccount?.profile?.nickname}');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset('assets/images/imgTest.png', fit: BoxFit.cover),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(20, 100, 20, 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(Strings.loginText1, style: MyTextStyle.bodyTextLarge1),
                    Text(Strings.loginText2, style: MyTextStyle.bodyTextLarge2)
                  ],
                )
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 550, 20, 50),
              child: TextButton(
                  onPressed: _kakaoLogin,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset('assets/images/kakao_login_large_wide.png'),
                  )
              ),
            )
          ],
        )
    );
  }
}