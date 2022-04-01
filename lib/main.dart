import 'package:after_school/model/state.dart';
import 'package:after_school/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';

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
    Future.delayed(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
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
