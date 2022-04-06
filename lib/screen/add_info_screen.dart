import 'package:after_school/model/state.dart';
import 'package:after_school/resources/MyTextStyle.dart';
import 'package:after_school/resources/Strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddInfoScreen extends StatefulWidget {
  const AddInfoScreen({Key? key}) : super(key: key);

  @override
  _AddInfoScreenState createState() => _AddInfoScreenState();
}

class _AddInfoScreenState extends State<AddInfoScreen> {
  late String _userImage;

  @override
  void initState() {
    super.initState();
    _userImage = context.read<UserState>().user.single.image;
    print(_userImage);
  }

  @override
  Widget build(BuildContext context) {
    final nameInputController = TextEditingController();

    _clickNext() {
      Navigator.push(context, MaterialPageRoute(builder: (_) => AddInfoScreen()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.addSchoolPage),
        actions: [
          TextButton(onPressed: _clickNext, child: Text("다음", style: TextStyle(color: Colors.black)))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.addInfoText1,
                      style: MyTextStyle.bodyTextLarge3),
                    SizedBox(height: 20,),
                    Text(
                      Strings.addInfoText2,
                      style: MyTextStyle.bodyTextMedium1),
                    Row(
                      children: [
                        Text(
                          Strings.addInfoText3,
                          style: MyTextStyle.bodyTextMedium2,
                        ),
                        Text(
                          Strings.addInfoText4,
                          style: MyTextStyle.bodyTextMedium1,
                        ),
                      ],
                    )
                  ],
                )
            ),
            Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: nameInputController,
                        maxLines: 1,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: Strings.addSchoolLabel1),
                      ),
                    ),
                    IconButton(
                      iconSize: 40,
                      onPressed: null,
                      icon: Icon(Icons.search, color: Colors.blue),
                    ),
                  ],
                )
            ),
            Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text(Strings.addInfoProfile),
                    SizedBox(width: 5),

                  ],
                )
            ),
            // Container(
            //   padding: EdgeInsets.only(top: 50),
            //   child: Center(
            //     child: TextButton(
            //       child: Text("다음"),
            //       onPressed: () {},
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}