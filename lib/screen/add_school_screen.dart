import 'package:after_school/resources/Strings.dart';
import 'package:after_school/screen/add_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

class AddSchoolScreen extends StatefulWidget {
  const AddSchoolScreen({Key? key, required this.nickname}) : super(key: key);
  final String nickname;

  @override
  _AddSchoolScreenState createState() => _AddSchoolScreenState();
}

class _AddSchoolScreenState extends State<AddSchoolScreen> {
  @override
  Widget build(BuildContext context) {
    final nameInputController = TextEditingController();

    void onError(PlacesAutocompleteResponse response) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage ?? 'Unknown error'),
        ),
      );
    }

    Future<void> _autoSearch() async {
      final Prediction? p = await PlacesAutocomplete.show(
        strictbounds: false,
        context: context,
        onError: onError,
        apiKey: dotenv.get('GOOGLE_APP_KEY'),
        mode: Mode.overlay, // Mode.fullscreen
        language: "ko",
        decoration: InputDecoration(
          hintText: '학교',
        )
      );
      nameInputController.text =  p?.structuredFormatting?.mainText ??"error";
      print(p?.description);
    }

    _clickNext() {
      //_join();
      Navigator.push(context, MaterialPageRoute(builder: (_) => const AddInfoScreen()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('2/3'),
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
                      Strings.addSchoolText1,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Row(
                      children: [
                        Text(
                          Strings.addSchoolLabel1,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          Strings.addSchoolText2,
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
                      onPressed: () => _autoSearch(),
                      icon: Icon(Icons.search, color: Colors.blue),
                    ),
                  ],
                )
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
                  onPressed: _clickNext,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}