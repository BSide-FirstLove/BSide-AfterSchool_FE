import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Text("소중한 추억을 찾기 위한 3초"),
          TextButton(
            onPressed: () {},
            child: Image.asset('assets/images/kakao_login_medium_wide.png'),
          )
        ],
      )
    );
  }
}