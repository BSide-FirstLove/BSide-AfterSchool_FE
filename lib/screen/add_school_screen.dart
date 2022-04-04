import 'package:after_school/resources/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

class AddSchool extends StatefulWidget {
  const AddSchool({Key? key, required this.nickname}) : super(key: key);
  final String nickname;

  @override
  _AddSchoolState createState() => _AddSchoolState();
}

class _AddSchoolState extends State<AddSchool> {
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
                  widget.nickname + Strings.addSchoolText1,
                  style: TextStyle(fontSize: 30, color: Colors.black45),)),
            Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: nameInputController,
                        maxLines: 1,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: '학교'),
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

  // @override
  // Widget build(BuildContext context) {
  //   final nameInputController = TextEditingController();
  //
  //   // _clickNext() {
  //   //   Navigator.push(context, MaterialPageRoute(builder: (_) => AddInfoScreen(nickname: modelLogin.nickname)));
  //   //   nameInputController.text
  //   // }
  //
  //   return Scaffold(
  //     appBar: AppBar(),
  //     body: SingleChildScrollView(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Container(
  //               padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
  //               child: Text(
  //                 nickname + Strings.addSchoolText1,
  //                 style: TextStyle(fontSize: 30, color: Colors.black45),)),
  //           Container(
  //             padding: EdgeInsets.all(20),
  //             child: Row(
  //               children: [
  //                 Flexible(
  //                   child: TextField(
  //                     controller: nameInputController,
  //                     maxLines: 1,
  //                     decoration: InputDecoration(
  //                         border: OutlineInputBorder(), labelText: '학교'),
  //                   ),
  //                 ),
  //                 IconButton(
  //                   iconSize: 40,
  //                   onPressed: () => _click(context),
  //                   icon: Icon(Icons.search, color: Colors.blue),
  //                   ),
  //               ],
  //             )
  //           ),
  //           Container(
  //               padding: EdgeInsets.all(20),
  //               child: Row(
  //                 children: [
  //                   Icon(Icons.info, color: Colors.blue),
  //                   SizedBox(width: 5),
  //                   Text("닉네임으로 해도 괜찮아 어쩌고저쩌고.", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)
  //                 ],
  //               )
  //           ),
  //           Container(
  //             padding: EdgeInsets.only(top: 50),
  //             child: Center(
  //               child: TextButton(
  //                 child: Text("다음"),
  //                 onPressed: () {},
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Future<void> _handlePressButton(BuildContext context) async {
  //   // show input autocomplete with selected mode
  //   // then get the Prediction selected
  //   Prediction? p = await PlacesAutocomplete.show(
  //     context: context,
  //     apiKey: "AIzaSyAiHzuyOcOGP1T-I5ujvihmkDVBRUF7-bE",
  //     mode: Mode.fullscreen,
  //     language: "ko",
  //     // decoration: InputDecoration(
  //     //   hintText: 'Search',
  //     //   focusedBorder: OutlineInputBorder(
  //     //     borderRadius: BorderRadius.circular(20),
  //     //     borderSide: BorderSide(
  //     //       color: Colors.white,
  //     //     ),
  //     //   ),
  //     // ),
  //     components: [Component(Component.country, "ko")],
  //   );
  //
  //   displayPrediction(p!, homeScaffoldKey.currentState);
  // }
  //
  // Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
  //   if (p != null) {
  //     scaffold.showSnackBar(
  //       SnackBar(content: Text("${p.description}")),
  //     );
  //   }
  // }






