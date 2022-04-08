import 'package:after_school/resources/MyColor.dart';
import 'package:after_school/resources/MyTextStyle.dart';
import 'package:after_school/resources/Strings.dart';
import 'package:after_school/screen/add_info_screen.dart';
import 'package:after_school/util/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:after_school/util/MyScreenUtil.dart';

class AddSchoolScreen extends StatefulWidget {
  const AddSchoolScreen({Key? key, required this.nickname}) : super(key: key);
  final String nickname;

  @override
  _AddSchoolScreenState createState() => _AddSchoolScreenState();
}

class _AddSchoolScreenState extends State<AddSchoolScreen> {
  @override
  Widget build(BuildContext context) {
    final _nameInputController = TextEditingController();
    final _startInputController = TextEditingController();
    final _endInputController = TextEditingController();

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
      _nameInputController.text =  p?.structuredFormatting?.mainText ??" ";
      print(p?.description);
      print(p?.placeId);
    }

    _clickNext() {
      //_join();
      Navigator.push(context, MaterialPageRoute(builder: (_) => const AddInfoScreen()));
    }

    _showStartDialog() {
      makePicker(context, _startInputController, Strings.addSchoolStartYear, 1950);
    }

    _showEndDialog() {
      if(_startInputController.text.isEmpty){
        showMsg(context, Strings.addSchoolAlert1);
      }else{
        int _startYear = int.parse(_startInputController.text.toString().replaceAll(" 년", ""));
        makePicker(context, _endInputController, Strings.addSchoolEndYear, _startYear);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(Strings.addNamePage),
        actions: [
          TextButton(onPressed: _clickNext, child: Text("다음", style: TextStyle(color: Colors.black)))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 16.w, top: 16.h, bottom: 16.h),
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
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    child: Text(Strings.addSchoolName, style: MyTextStyle.bodyTextLabel1),
                  ),
                  InkWell(
                    onTap: _autoSearch,
                    child: TextField(
                      controller: _nameInputController,
                      enabled: false,
                      decoration: InputDecoration(
                        // hintText: Strings.addSchoolHint1
                          suffixIcon: Icon(Icons.school_outlined)
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 28.h),
                      child: Text(Strings.addSchoolText3, style: MyTextStyle.bodyTextAlert)
                  ),
                ],
              )
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Strings.addSchoolStartYear, style: MyTextStyle.bodyTextLabel1),
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: 150.w,
                      height: 44.h,
                      child: InkWell(
                        onTap: _showStartDialog,
                        child: TextField(
                          controller: _startInputController,
                          enabled: false,
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.date_range_outlined)
                          ),
                        ),
                      )
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Strings.addSchoolEndYear, style: MyTextStyle.bodyTextLabel1),
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: 150.w,
                      height: 44.h,
                        child: InkWell(
                          onTap: _showEndDialog,
                          child: TextField(
                            controller: _endInputController,
                            enabled: false,
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.date_range_outlined)
                            ),
                          ),
                        )
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 119.h),
            child: Center(
              child: myButton(300.w, 50.h, MyColor.buttonGrey, "다음", _clickNext),
            ),
          )
        ],
      ),
    );
  }
}