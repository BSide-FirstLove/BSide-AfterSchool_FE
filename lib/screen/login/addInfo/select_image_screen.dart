import 'dart:io';

import 'package:after_school/common/resources/MyTextStyle.dart';
import 'package:after_school/common/util/MyScreenUtil.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageScreen extends StatefulWidget {
  const SelectImageScreen({Key? key, required this.image}) : super(key: key);
  final image;

  @override
  State<StatefulWidget> createState() => _SelectImageScreenState();
}

class _SelectImageScreenState extends State<SelectImageScreen> {
  bool _isNetworkImg = true;
  bool _buttonSwitch = false;

  XFile? _imageFile;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
      );
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Widget _previewImages() {
    if (_imageFile != null) {
      return Semantics(
        label: 'image_picker_example_picked_image',
        child: kIsWeb
            ? Image.network(_imageFile!.path, fit: BoxFit.fill)
            : Image.file(File(_imageFile!.path), fit: BoxFit.fill),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  _clickButton() {
    setState(() {
      _buttonSwitch = !_buttonSwitch;
    });
  }

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
                child: _previewImages()),
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
                      height: _buttonSwitch ?223.h :0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              _clickButton();
                            },
                            child: Text("편집",
                                style: MyTextStyle.selectImageButton),
                          ),
                          // Container( height:1.h, color:Color(0xFFE1E1E1), margin: EdgeInsets.fromLTRB(22.w, 17.h, 22.w, 17.h)),
                          Container(
                              height: 1.h,
                              color: Color(0xFFE1E1E1),
                              margin: EdgeInsets.only(left: 22.w, right: 22.w)),
                          InkWell(
                            onTap: () {
                              _clickButton();
                              _onImageButtonPressed(ImageSource.gallery, context: context);
                            },
                            child: Text("사진첩에서 선택",
                                style: MyTextStyle.selectImageButton),
                          ),
                          Container(
                              height: 1.h,
                              color: Color(0xFFE1E1E1),
                              margin: EdgeInsets.only(left: 22.w, right: 22.w)),
                          InkWell(
                            onTap: () {
                              _clickButton;
                              _onImageButtonPressed(ImageSource.camera, context: context);
                            },
                            child: Text("카메라로 촬영",
                                style: MyTextStyle.selectImageButton),
                          ),
                          Container(
                              height: 1.h,
                              color: Color(0xFFE1E1E1),
                              margin: EdgeInsets.only(left: 22.w, right: 22.w)),
                          InkWell(
                            onTap: () {
                              _clickButton;
                            },
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
                                onPressed: _clickButton,
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
