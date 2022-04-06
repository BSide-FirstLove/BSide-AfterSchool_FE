import 'package:after_school/resources/MyColor.dart';
import 'package:after_school/resources/MyTextStyle.dart';
import 'package:after_school/resources/Strings.dart';
import 'package:after_school/util/MyScreenUtil.dart';
import 'package:flutter/material.dart';

import '../util/MyWidget.dart';
import 'add_school_screen.dart';

class AddNameScreen extends StatelessWidget {
  const AddNameScreen({Key? key, required this.nickname}) : super(key: key);
  final String nickname;

  @override
  Widget build(BuildContext context) {
    final nameInputController = TextEditingController(text: nickname);

    _clickNext() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  AddSchoolScreen(nickname: nameInputController.text)));
    }

    return Scaffold(
      //  키보드 밀림 방지
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(Strings.loginTextPage),
        actions: [
          TextButton(
              onPressed: _clickNext,
              child: Text("다음", style: TextStyle(color: Colors.black)))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 16.w, top: 16.h, bottom: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    Strings.addNameText1,
                    style: MyTextStyle.bodyTextMedium1,
                  ),
                  Row(
                    children: const [
                      Text(
                        Strings.addNameLabel1,
                        style: MyTextStyle.bodyTextMedium2,
                      ),
                      Text(
                        Strings.addNameText2,
                        style: MyTextStyle.bodyTextMedium1,
                      )
                    ],
                  ),
                ],
              )),
          Container(
              padding: EdgeInsets.only(left: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    child: Text(Strings.addNameLabel2),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: nameInputController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.cancel_outlined)
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.clear),
                        iconSize: 30,
                        padding: EdgeInsets.all(18),
                        color: MyColor.icon,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Text(Strings.addNameText3, style: MyTextStyle.bodyTextAlert)
                  )
                ],
              )),
          Container(
            padding: EdgeInsets.only(top: 218.h),
            child: Center(
              child: myButton(300.w, 50.h, MyColor.buttonGrey, "다음", _clickNext),
            ),
            //   OutlinedButton(
            //     style: OutlinedButton.styleFrom(
            //         fixedSize: Size(
            //             MediaQuery.of(context).size.width*300/360,
            //             MediaQuery.of(context).size.height*50/640),
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(10)))),
            //     child: Text("다음"),
            //     onPressed: _clickNext,
            //   ),
          )
        ],
      ),
    );
  }
}
