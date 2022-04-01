import 'package:after_school/model/state.dart';
import 'package:after_school/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';
import 'package:after_school/model/user.dart' as my_user;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = false;

  _checkToken() async {
    try{
      await UserApi.instance.accessTokenInfo();
      setState(() {
        isLogin = true;
      });
    } catch (error) {
      if (error is KakaoException && error.isInvalidTokenError()) {
        print('토큰 만료 $error');
      } else {
        print('토큰 정보 조회 실패 $error');
      }
    }
  }

  _kakaoLogin() async {
    // 카카오톡 설치 여부 확인
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공11');
        print(token);
        _loginSuccess();
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {}
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공22');
          print(token);
          _loginSuccess();
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공33');
        print(token);
        _loginSuccess();
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  _loginSuccess() async {
    await _getUser();
    setState(() {
      isLogin = true;
    });
  }

  _loginFailed() { }

  _getUser() async {
    try {
      User kakaoUser = await UserApi.instance.me();
      // context.watch<UserState>().add(
      Provider.of<UserState>(context, listen: false).add(
          my_user.User.fromKakao(kakaoUser)
      );
      print('사용자 정보 요청 성공'
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
    return isLogin? const HomeScreen() :
    Scaffold(
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
                  children: [
                    Text("소중한 \n추억을 찾기 위한", style: TextStyle(fontSize: 40, height: 1.2)),
                    Text("3초", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, height: 1.2))
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