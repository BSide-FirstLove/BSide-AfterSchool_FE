import 'package:after_school/model/state.dart';
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
        title: Text('3/3'),
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
                      style: Theme.of(context).textTheme.headline4,),
                    SizedBox(height: 20,),
                    Text(
                      Strings.addInfoText2,
                      style: Theme.of(context).textTheme.headline5,),
                    Row(
                      children: [
                        Text(
                          Strings.addInfoText3,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          Strings.addInfoText4,
                          style: Theme.of(context).textTheme.headline5,
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