import 'package:after_school/common/model/api/Login.dart';
import 'package:after_school/common/model/api/ModelResponse.dart';
import 'package:after_school/common/model/state.dart';
import 'package:after_school/common/resources/MyTextStyle.dart';
import 'package:after_school/common/resources/Strings.dart';
import 'package:after_school/common/util/MyScreenUtil.dart';
import 'package:after_school/common/util/MyHttp.dart';
import 'package:after_school/common/util/MyWidget.dart';
import 'package:after_school/screen/login/add_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';
import 'package:after_school/common/model/user.dart' as my_user;
import 'package:shared_preferences/shared_preferences.dart';
import '../main/home_screen.dart';
import 'add_name_screen.dart';

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

    try{
      MyHttp().setKakaoToken(token);
      Login modelLogin = await MyHttp().login(LoginReq(accessToken: token));
      if(modelLogin.isNewMember) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => AddNameScreen(nickname: modelLogin.nickname!)));
      }else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
    } catch(error) {
      showMsg(context, Strings.errorLogin);
      print(error);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AddInfoScreen()),
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
              width: double.infinity,
              height: double.infinity,
              child: Image.asset('assets/images/imgTest.png', fit: BoxFit.fill),
            ),
            Container(
                padding: EdgeInsets.only(left: 21.w, top: 95.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(Strings.loginText1, style: MyTextStyle.bodyTextLarge1),
                    Text(Strings.loginText2, style: MyTextStyle.bodyTextLarge2)
                  ],
                )
            ),
            Container(
              padding: EdgeInsets.only(top: 494.h, left: 30.w, right: 30.w),
              child: TextButton(
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                child: Image.asset('assets/images/kakao_login_large_wide.png'),
                onPressed: _kakaoLogin,
              ),
            )
          ],
        )
    );
  }
}