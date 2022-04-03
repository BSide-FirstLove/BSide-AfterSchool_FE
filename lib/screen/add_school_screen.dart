import 'package:after_school/resources/Strings.dart';
import 'package:flutter/material.dart';

class AddSchool extends StatelessWidget {
  const AddSchool({Key? key, required this.nickname}) : super(key: key);
  final String nickname;

  @override
  Widget build(BuildContext context) {
    final nameInputController = TextEditingController();

    // _clickNext() {
    //   Navigator.push(context, MaterialPageRoute(builder: (_) => AddInfoScreen(nickname: modelLogin.nickname)));
    //   nameInputController.text
    // }

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                child: Text(
                  nickname + Strings.addSchoolText1,
                  style: TextStyle(fontSize: 30, color: Colors.black45),)),
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: nameInputController,
                maxLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: '이름'),
              ),
            ),
            Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.blue),
                    SizedBox(width: 5),
                    Text("닉네임으로 해도 괜찮아 어쩌고저쩌고.", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)
                  ],
                )
            ),
            Container(
              padding: EdgeInsets.only(top: 50),
              child: Center(
                child: TextButton(
                  child: Text("다음"),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}