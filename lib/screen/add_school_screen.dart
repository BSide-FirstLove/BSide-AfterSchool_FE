import 'package:after_school/resources/MyTextStyle.dart';
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
        logo: Text(""),
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white10)
          ),
          filled: false,
          hintText: '학교',
        )
      );
      nameInputController.text =  p?.structuredFormatting?.mainText ??" ";
      print(p?.description);
    }

    _clickNext() {
      //_join();
      Navigator.push(context, MaterialPageRoute(builder: (_) => const AddInfoScreen()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.addNamePage),
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
                    Row(
                      children: [
                        Text(
                          widget.nickname,
                          style: MyTextStyle.bodyTextMedium2,
                        ),
                        Text(
                          Strings.addSchoolText1,
                          style: MyTextStyle.bodyTextMedium1,
                        ),
                      ],
                    ),
                    Text(
                      Strings.addSchoolText2,
                      style: MyTextStyle.bodyTextMedium1,
                    ),
                  ],
                )
            ),
            Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Strings.addSchoolName, style: MyTextStyle.bodyTextLabel1),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Flexible(
                          child: TextField(
                            controller: nameInputController,
                            maxLines: 1,
                            // decoration: InputDecoration(
                            //     hintText: Strings.addSchoolHint1),
                          ),
                        ),
                        IconButton(
                          iconSize: 40,
                          onPressed: () => _autoSearch(),
                          icon: Icon(Icons.search, color: Colors.blue),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.info, color: Colors.blue),
                        SizedBox(width: 5),
                        Text(Strings.addSchoolText3, style: TextStyle(color: Color(0xFFBABABA), fontWeight: FontWeight.w500))
                      ],
                    )
                  ],
                )
            ),
            // Container(
            //   padding: EdgeInsets.only(top: 50),
            //   child:
            //   ElevatedButton(
            //       style: ButtonStyle(
            //         backgroundColor: MaterialStateProperty.all(Colors.white10),
            //         shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
            //       ),
            //       // minWidth: 300,
            //       // height: 50,
            //       // color: Colors.white10,
            //       onPressed: _clickNext,
            //       child: SizedBox(
            //         width: 300,
            //         height: 50,
            //         child: Text("다음"),
            //       )
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}