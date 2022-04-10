import 'dart:io';

import 'package:after_school/common/model/ImageModel.dart';
import 'package:after_school/common/resources/MyTextStyle.dart';
import 'package:after_school/common/resources/Strings.dart';
import 'package:after_school/common/util/MyScreenUtil.dart';
import 'package:after_school/screen/login/addInfo/edit_image_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageScreen extends StatefulWidget {
  const SelectImageScreen({Key? key, required this.imageState}) : super(key: key);
  final ModelImageState imageState;
  // final dynamic imageData;

  @override
  State<StatefulWidget> createState() => _SelectImageScreenState();
}

class _SelectImageScreenState extends State<SelectImageScreen> {
  // late bool _isNetworkImg;
  bool _buttonSwitch = false;
  XFile? _imageFile;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // _isNetworkImg = widget.isNetworkImg;
    // if(!_isNetworkImg){
    //   _imageFile = widget.imageData;
    // }
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    // try {
    //   _imageFile = null;
    //   final XFile? pickedFile = await _picker.pickImage(
    //     source: source,
    //   );
    //   setState(() {
    //     _imageFile = pickedFile;
    //   });
    //     _isNetworkImg = false;
    // } catch (e) {
    //   setState(() {
    //     _pickImageError = e;
    //   });
    // }
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
      );
      setState(() {
        widget.imageState.image = pickedFile;
        widget.imageState.type = ModelImageState.MEMORY;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Widget _previewImages() {
    // if(_isNetworkImg){
    //   return Image.network(widget.imageData, fit: BoxFit.fill);
    // }else{
    //   if (_imageFile != null) {
    //     return kIsWeb
    //         ? Image.network(_imageFile!.path, fit: BoxFit.fill)
    //         : Image.file(File(_imageFile!.path), fit: BoxFit.fill);
    //   } else if (_pickImageError != null) {
    //     return Center(
    //       child: Text(
    //         Strings.selectImageErrorPick + _pickImageError,
    //       )
    //     );
    //   } else {
    //     //  편집데이터 못가져옴
    //     return Center(
    //         child: Text(Strings.selectImageErrorUnknown)
    //     );
    //   }
    // }
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

    _imageFile = await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => EditImageScreen(imageFile: _imageFile!))
    );
    if(_imageFile == null) {
    //  편집 데이터 가져오기 실패
    }else{
      // setState(() {
      //   _imageFile;
      // });
    }
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