import 'package:flutter/material.dart';

class AddInfoScreen extends StatelessWidget {
  const AddInfoScreen({Key? key, required this.nickname}) : super(key: key);
  final String nickname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text(nickname)),
    );
  }

}