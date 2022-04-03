import 'package:after_school/resources/Strings.dart';
import 'package:flutter/material.dart';

import 'add_school_screen.dart';

class AddName extends StatelessWidget {
  const AddName({Key? key, required this.nickname}) : super(key: key);
  final String nickname;

  @override
  Widget build(BuildContext context) {
    final nameInputController = TextEditingController(text: nickname);

    _clickNext() {
      Navigator.push(context, MaterialPageRoute(builder: (_) => AddSchool(nickname: nameInputController.text)));
    }

    return Scaffold(
      //  키보드 밀림 방지
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        //  경계선 제거
        // elevation: 0,
        // backgroundColor: Colors.white10,
        // leading: BackButton(color: Colors.black45),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Text(
              Strings.addNameText1,
              style: TextStyle(fontSize: 30, color: Colors.black45),)),
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: nameInputController,
              maxLines: 1,
              // decoration: InputDecoration(
              //     border: OutlineInputBorder(), labelText: '이름'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.info, color: Colors.blue),
                SizedBox(width: 5),
                Text(Strings.addNameText2, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)
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