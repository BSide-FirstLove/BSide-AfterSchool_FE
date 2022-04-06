import 'package:flutter/material.dart';
import 'package:after_school/util/MyScreenUtil.dart';
import 'package:flutter/rendering.dart';

myShowDialog(BuildContext context, String title, String content) {
  showDialog(
      context: context,
      barrierDismissible: true, //Dialog를 제외한 다른 화면 터치시 닫기 여부
      builder: (BuildContext context) {
        return AlertDialog(
          // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)),
          //Dialog Main Title
          title: Column(
            children: <Widget>[
              Text("입학년도"),
            ],
          ),
          //
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(content),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

myShowDialog2(BuildContext context){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(10.0)), //this right here
          child: Container(
            width: 500,
            height: 187.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'What do you want to remember?'),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      OutlinedButton(
                        child: Text("취소"),
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            // fixedSize: Size(double.infinity/2, double.infinity/2),
                            ),
                      ),
                      OutlinedButton(
                        child: Text("확인"),
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            ),
                      )
                    ],
                  )
                )
              ],
            ),
          ),
        );
      });
}

Widget myButton(double width, double height, Color color, String text, onPressed) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
        backgroundColor: color,
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)))),
    child: Text(text, style: TextStyle(color: Colors.white)),
    onPressed: onPressed,
  );
}