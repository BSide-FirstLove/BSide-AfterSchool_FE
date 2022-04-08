import 'package:after_school/model/api/Join.dart';
import 'package:after_school/resources/MyColor.dart';
import 'package:after_school/resources/MyTextStyle.dart';
import 'package:after_school/resources/Strings.dart';
import 'package:after_school/screen/add_info_screen.dart';
import 'package:after_school/util/MyHttp.dart';
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
  final _schoolNameInputController = TextEditingController();
  final _startInputController = TextEditingController();
  final _endInputController = TextEditingController();
  late String _placeId;
  bool _validity = false;

  @override
  void initState() {
    super.initState();
    _schoolNameInputController.addListener(_checkValidity);
    _startInputController.addListener(_checkValidity);
    _startInputController.addListener(() {_endInputController.text = ""; });
    _endInputController.addListener(_checkValidity);
  }

  @override
  void dispose() {
    _schoolNameInputController.dispose();
    _startInputController.dispose();
    _endInputController.dispose();
    super.dispose();
  }

  _checkValidity() {
    if(_schoolNameInputController.text.isNotEmpty &&
        _startInputController.text.isNotEmpty &&
        _endInputController.text.isNotEmpty) {
      setState(() {
        _validity = true;
      });
    }else {
      setState(() {
        _validity = false;
      });
    }
  }

  Future<void> _autoSearch() async {
    final Prediction? p = await PlacesAutocomplete.show(
        strictbounds: false,
        context: context,
        onError: (response) => showMsg(context, response.errorMessage??"Unknown error"),
        apiKey: dotenv.get('GOOGLE_APP_KEY'),
        mode: Mode.overlay, // Mode.fullscreen
        language: "ko",
        logo: Text(""),
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white10)
          ),
          filled: false,
          hintText: '서울중학교',
        )
    );
    if(p != null){
      _schoolNameInputController.text = p.structuredFormatting?.mainText ??"";
      _placeId = p.placeId!;
    }

    print("description : ${p?.description}"
        "\n1 : ${p?.reference}"
        "\n2 : ${p?.id}"
        "\n3 : ${p?.distanceMeters}"
        "\n4 : ${p?.placeId}"
        "\n5 : ${p?.structuredFormatting?.mainText}"
        "\n6 : ${p?.structuredFormatting?.secondaryText}"
        "\n7 : ${p?.terms.first.value}"
        "\n71 : ${p?.terms.length}"
        "\n72 : ${p?.terms[1].value}"
        // "\n73 : ${p?.terms[3].value}"
        "\n7 : ${p?.types.first}"
        "\n7 : ${p?.types.length}"
    );
  }

  _showStartDialog() {
    makePicker(context, _startInputController, Strings.addSchoolStartYear, 1950);
  }

  _showEndDialog() {
    if(_startInputController.text.isEmpty){
      showMsg(context, Strings.addSchoolMsg1);
    }else{
      int _startYear = int.parse(_startInputController.text.toString().replaceAll(" 년", ""));
      makePicker(context, _endInputController, Strings.addSchoolEndYear, _startYear);
    }
  }

  _clickNext() {
    // if(_validity) {
    //   try{
    //     var data = JoinReq(
    //         accessToken: MyHttp().kakaoToken,
    //         placeId: _placeId,
    //         enterYear: _startInputController.text,
    //         endYear: _endInputController.text,
    //         nickname: widget.nickname);
    //     MyHttp().join(data);
    //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AddInfoScreen()));
    //   } catch(e){
    //     showMsg(context, Strings.errorJoin);
    //     print(e);
    //   }
    // }else {
    //   String msg = "";
    //   if(_schoolNameInputController.text.isEmpty) {
    //     msg = Strings.addSchoolMsg2;
    //   } else if(_startInputController.text.isEmpty) {
    //     msg = Strings.addSchoolMsg3;
    //   } else if(_endInputController.text.isEmpty) {
    //     msg = Strings.addSchoolMsg4;
    //   }
    //   showMsg(context, msg);
    // }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AddInfoScreen()));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(Strings.addNamePage),
        actions: [
          TextButton(onPressed: _clickNext, child: Text(Strings.next, style: TextStyle(color: Colors.black)))
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
                      controller: _schoolNameInputController,
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
              padding: EdgeInsets.only(top: 119.h, left: 30.w, right: 30.w),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50.h,
                      child: myButton(_validity? MyColor.buttonValidity :MyColor.buttonGrey, "다음", _clickNext),
                    ),
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}