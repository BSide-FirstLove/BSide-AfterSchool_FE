import 'package:after_school/common/resources/MyTextStyle.dart';
import 'package:after_school/common/util/MyScreenUtil.dart';
import 'package:after_school/common/util/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectImageScreen extends StatefulWidget {
  const SelectImageScreen({Key? key, required this.image}) : super(key: key);
  final image;

  @override
  State<StatefulWidget> createState() => _SelectImageScreenState();
}

class _SelectImageScreenState extends State<SelectImageScreen> {
  bool _isNetworkImg = true;
  bool _buttonSwitch = false;
  double _height = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body위에 appbar
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          //  뒤로가기 제거
          automaticallyImplyLeading: false,
          leading: null,
          backgroundColor: Colors.transparent,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.clear))],
        ),
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset("assets/images/imgTest.png", fit: BoxFit.fill),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // AnimatedContainer(
                AnimatedSize(
                    duration: Duration(milliseconds: 360),
                    // 애니메이션 효과 커브
                    curve: Curves.fastOutSlowIn, //Curves.fastOutSlowIn
                    child: Container(
                      margin:
                          EdgeInsets.only(left: 10.w, right: 10.w, bottom: 8.h),
                      width: double.infinity,
                      height: _height,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Text("편집",
                                style: MyTextStyle.selectImageButton),
                          ),
                          // Container( height:1.h, color:Color(0xFFE1E1E1), margin: EdgeInsets.fromLTRB(22.w, 17.h, 22.w, 17.h)),
                          Container(
                              height: 1.h,
                              color: Color(0xFFE1E1E1),
                              margin: EdgeInsets.only(left: 22.w, right: 22.w)),
                          InkWell(
                            onTap: () {},
                            child: Text("사진첩에서 선택",
                                style: MyTextStyle.selectImageButton),
                          ),
                          Container(
                              height: 1.h,
                              color: Color(0xFFE1E1E1),
                              margin: EdgeInsets.only(left: 22.w, right: 22.w)),
                          InkWell(
                            onTap: () {},
                            child: Text("카메라로 촬영",
                                style: MyTextStyle.selectImageButton),
                          ),
                          Container(
                              height: 1.h,
                              color: Color(0xFFE1E1E1),
                              margin: EdgeInsets.only(left: 22.w, right: 22.w)),
                          InkWell(
                            onTap: () {},
                            child: Text("프로필 사진 삭제",
                                style: MyTextStyle.selectImageButtonRed),
                          ),
                        ],
                      ),
                    )),
                Container(
                    padding:
                        EdgeInsets.only(bottom: 8.h, left: 10.w, right: 10.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                              height: 59.h,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                                child: _buttonSwitch
                                    ? Text("취소",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20))
                                    : Text("설정",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20)),
                                onPressed: () {
                                  setState(() {
                                    _height == 0 ? _height = 223 : _height = 0;
                                    _buttonSwitch = !_buttonSwitch;
                                  });
                                },
                              )),
                        )
                      ],
                    )),
              ],
            ),
          ],
        ));
  }
}
