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
        title: Text('1/3'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.addNameText1,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Row(children: [
                  Text(
                    Strings.addNameLabel1,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    Strings.addNameText2,
                    style: Theme.of(context).textTheme.headline5,
                  )
                ],),
              ],
            )
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: nameInputController,
              maxLines: 1,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: Strings.addNameLabel1),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.info, color: Colors.blue),
                SizedBox(width: 5),
                Text(Strings.addNameText3, style: Theme.of(context).textTheme.caption,)
              ],
            )
          ),
          Container(
            padding: EdgeInsets.only(top: 50),
            child: Center(
              child: TextButton(
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