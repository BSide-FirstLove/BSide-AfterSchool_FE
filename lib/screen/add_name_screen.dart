import 'package:after_school/resources/MyTextStyle.dart';
import 'package:after_school/resources/Strings.dart';
import 'package:flutter/material.dart';

import 'add_school_screen.dart';

class AddNameScreen extends StatelessWidget {
  const AddNameScreen({Key? key, required this.nickname}) : super(key: key);
  final String nickname;

  @override
  Widget build(BuildContext context) {
    final nameInputController = TextEditingController(text: nickname);

    _clickNext() {
      Navigator.push(context, MaterialPageRoute(builder: (_) => AddSchoolScreen(nickname: nameInputController.text)));
    }

    return Scaffold(
      //  키보드 밀림 방지
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: Text(Strings.loginTextPage),
        actions: [
          TextButton(onPressed: _clickNext, child: Text("다음", style: TextStyle(color: Colors.black)))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.addNameText1,
                  style: MyTextStyle.bodyTextMedium1,
                ),
                Row(children: [
                  Text(
                    Strings.addNameLabel1,
                    style: MyTextStyle.bodyTextMedium2,
                  ),
                  Text(
                    Strings.addNameText2,
                    style: MyTextStyle.bodyTextMedium1,
                  )
                ],),
              ],
            )
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: nameInputController,
              maxLines: 1,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Text(Strings.addNameText3, style: MyTextStyle.bodyTextAlert)
              ],
            )
          ),
          Container(
            padding: EdgeInsets.only(top: 50),
            child: Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  fixedSize: Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  )
                ),
                child: Text("다음"),
                onPressed: _clickNext,
              ),
            ),
          )
        ],
      ),
    );
  }

}