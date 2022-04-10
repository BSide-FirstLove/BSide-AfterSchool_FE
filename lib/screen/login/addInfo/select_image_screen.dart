import 'dart:io';

import 'package:after_school/common/model/ImageModel.dart';
import 'package:after_school/common/resources/MyTextStyle.dart';
import 'package:after_school/common/resources/Strings.dart';
import 'package:after_school/common/util/MyScreenUtil.dart';
import 'package:after_school/screen/login/addInfo/edit_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageScreen extends StatefulWidget {
  const SelectImageScreen({Key? key, required this.imageState}) : super(key: key);
  final ModelImageState imageState;

  @override
  State<StatefulWidget> createState() => _SelectImageScreenState();
}

class _SelectImageScreenState extends State<SelectImageScreen> {
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
      if(pickedFile != null){
        setState(() {
          widget.imageState.image = pickedFile;
          widget.imageState.type = ModelImageState.MEMORY;
        });
      }
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Widget _previewImages() {
    if(widget.imageState.image == null){
      return Center(
          child: Text(Strings.selectImageErrorLoad)
      );
    }
    else if (_pickImageError != null) {
      return Center(
          child: Text(
            Strings.selectImageErrorPick + _pickImageError,
          )
      );
    }
    switch(widget.imageState.type) {
      case ModelImageState.KAKAO :
        return Image.network(widget.imageState.image, fit: BoxFit.fill);
      case ModelImageState.BASIC :
        return Image.network(widget.imageState.image, fit: BoxFit.fill);
      case ModelImageState.MEMORY :
        return Image.file(File(widget.imageState.image.path), fit: BoxFit.fill);
      default :
        return Center(
            child: Text(Strings.selectImageErrorUnknown)
        );
    }
  }

  _clickButton() {
    setState(() {
      _buttonSwitch = !_buttonSwitch;
    });
  }

  _clickEditImage() async {
    //네트워크이미지or선택이미지 확인후 네트워크일시 파일변환 후 데이터 들고 이동

    await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => EditImageScreen(imageState: widget.imageState))
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body위에 appbar
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          //  뒤로가기 제거
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.clear)
            )
          ],
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
                              _clickEditImage();
                            },
                            child: Text(
                                Strings.selectImageEdit,
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
                            child: Text(Strings.selectImageGallery,
                                style: MyTextStyle.selectImageButton),
                          ),
                          Container(
                              height: 1.h,
                              color: Color(0xFFE1E1E1),
                              margin: EdgeInsets.only(left: 22.w, right: 22.w)),
                          InkWell(
                            onTap: () {
                              _clickButton();
                              _onImageButtonPressed(ImageSource.camera, context: context);
                            },
                            child: Text(Strings.selectImageCamera,
                                style: MyTextStyle.selectImageButton),
                          ),
                          Container(
                              height: 1.h,
                              color: Color(0xFFE1E1E1),
                              margin: EdgeInsets.only(left: 22.w, right: 22.w)),
                          InkWell(
                            onTap: () {
                              _clickButton();
                              setState(() {
                                widget.imageState.type = ModelImageState.BASIC;
                                widget.imageState.image = ModelImageState.basicImage;
                              });
                            },
                            child: Text(Strings.selectImageDelete,
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
                                    ? Text(Strings.selectImageButtonCancel,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20))
                                    : Text(Strings.selectImageButtonSetting,
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