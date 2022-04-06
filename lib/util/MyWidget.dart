import 'package:flutter/material.dart';

myShowDialog(BuildContext context, String title, String content) {
  showDialog(
      context: context,
      //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)),
          //Dialog Main Title
          title: Column(
            children: <Widget>[
              Text(title),
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
            new FlatButton(
              child: new Text("확인"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}

Widget myButton(BuildContext context, double width, double height, Color color, String text, onPressed) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
        backgroundColor: color,
        fixedSize: Size(
            MediaQuery.of(context).size.width * width/360,
            MediaQuery.of(context).size.height * height/640),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)))),
    child: Text(text, style: TextStyle(color: Colors.white)),
    onPressed: onPressed,
  );
}