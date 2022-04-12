import 'dart:io';

import 'package:after_school/common/model/ImageModel.dart';
import 'package:after_school/common/model/api/UserUpdate.dart';
import 'package:after_school/common/model/state.dart';
import 'package:after_school/common/model/user.dart';
import 'package:after_school/common/resources/MyColor.dart';
import 'package:after_school/common/resources/MyTextStyle.dart';
import 'package:after_school/common/resources/Strings.dart';
import 'package:after_school/common/util/MyHttp.dart';
import 'package:after_school/common/util/MyScreenUtil.dart';
import 'package:after_school/common/widget/MyWidget.dart';
import 'package:after_school/screen/login/addInfo/select_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'addInfo/input_instar_screen.dart';

class AddInfoScreen extends StatefulWidget {
  const AddInfoScreen({Key? key}) : super(key: key);

  @override
  _AddInfoScreenState createState() => _AddInfoScreenState();
}

class _AddInfoScreenState extends State<AddInfoScreen> {
  final _instarInputController = TextEditingController();
  final _jobInputController = TextEditingController();
  final _descriptionInputController = TextEditingController();
  late User _user;
  bool _validity = false;
  late ModelImageState _imageState;

  @override
  void initState() {
    super.initState();
    _instarInputController.addListener(_checkValidity);
    _jobInputController.addListener(_checkValidity);
    _descriptionInputController.addListener(_checkValidity);
    _user = context.read<UserState>().user.first;
    print(_user.image);
    _imageState = ModelImageState(type: ModelImageState.KAKAO, image: _user.image);
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle());
    _instarInputController.dispose();
    _jobInputController.dispose();
    _descriptionInputController.dispose();
    super.dispose();
  }

  _checkValidity() {
    if(_instarInputController.text.isNotEmpty &&
        _jobInputController.text.isNotEmpty &&
        _descriptionInputController.text.isNotEmpty) {
      setState(() {
        _validity = true;
      });
    }else {
      setState(() {
        _validity = false;
      });
    }
  }

  ImageProvider<Object> _loadImage() {
    switch(_imageState.type) {
      case ModelImageState.KAKAO :
        return NetworkImage(_imageState.image);
      case ModelImageState.BASIC :
        return NetworkImage(_imageState.image);
      case ModelImageState.FILE :
        return FileImage(File(_imageState.image.path));
      case ModelImageState.EDIT :
        return MemoryImage(_imageState.image);
      default :
        return NetworkImage(ModelImageState.basicImage);
    }
  }
  Widget _loadImage2() {
    switch(_imageState.type) {
      case ModelImageState.KAKAO :
        return Image.network(_imageState.image, fit: BoxFit.fill);
      case ModelImageState.BASIC :
        return Image.network(_imageState.image, fit: BoxFit.fill);
      case ModelImageState.FILE :
        return Image.file(File(_imageState.image.path), fit: BoxFit.fill);
      case ModelImageState.EDIT :
        return Image.memory(_imageState.image, fit: BoxFit.fill);
      default :
        return Image.network(ModelImageState.basicImage);
    }
  }

  _selectImage() async {
    await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => SelectImageScreen(imageState: _imageState))
    );
    setState(() {});
  }

  _inputInstar() async {
    String instar = await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => InputInstarScreen())
    );
    print(instar);
    _instarInputController.text = instar;
  }

  _clickCancel() {
    //  이전 페이지 제거 후 이동
    Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
  }

  _clickOk() {
    if(_validity) {
      // 추가정보 api 통신 후 메인 페이지 이동
      // Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
      try {
        var data = UserUpdateReq(
            instagramId: _instarInputController.text,
            job: _jobInputController.text,
            description: _descriptionInputController.text);
        MyHttp().userUpdate(data);
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
      }on Exception catch (e) {
        showMsg(context, Strings.errorUserUpdate);
        print(e);
      }
    }else {
        String msg = "";
        if(_instarInputController.text.isEmpty) {
          msg = Strings.addInstarMsg1;
        } else if(_jobInputController.text.isEmpty) {
          msg = Strings.addInstarMsg2;
        } else if(_descriptionInputController.text.isEmpty) {
          msg = Strings.addInstarMsg3;
        }
        showMsg(context, msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent //상태바 투명
            ),
            backgroundColor: MyColor.loginYello,
            title: Text(Strings.addSchoolPage),
            iconTheme: IconThemeData(color: Colors.white),
            actions: [
              TextButton(
                  onPressed: _clickOk,
                  child: Text(Strings.completion,
                      style: TextStyle(color: Colors.white)))
            ],
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 165.h,
                      decoration: const BoxDecoration(
                        color: MyColor.loginYello,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(3.0, 3.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-3.0, -3.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(Strings.addInfoTitle1,
                              style: MyTextStyle.addInfoTitleLarge),
                          SizedBox(height: 8.h),
                          Text(Strings.addInfoTitle2,
                              style: MyTextStyle.addInfoTitleSmall),
                          SizedBox(height: 16.h)
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 100.h, left: 16.w, right: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 4.w, right: 4.w),
                            child: Text(Strings.addInfoInstar, style: MyTextStyle.addInfoBodyLabel),
                          ),
                          InkWell(
                            onTap: _inputInstar,
                            child: TextField(
                                controller: _instarInputController,
                                enabled: false,
                                decoration: InputDecoration(
                                    filled: false,
                                    suffixIcon: Icon(Icons.arrow_forward_ios, color: Color(0xFFAEAEAE)),
                                    disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFD5D6D8),
                                        )
                                    )
                                )
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 24.h),
                            child: Text(Strings.addInfoJob, style: MyTextStyle.addInfoBodyLabel),
                          ),
                          TextField(
                              controller: _jobInputController,
                              decoration: InputDecoration(
                                  filled: false,
                                  suffixIcon: Icon(Icons.arrow_forward_ios, color: Color(0xFFAEAEAE)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFD5D6D8),
                                      )
                                  )
                              )
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 24.h, bottom: 8.h),
                            child: Text(Strings.addInfoDescription, style: MyTextStyle.addInfoBodyLabel),
                          ),
                          TextField(
                              controller: _descriptionInputController,
                              maxLines: 7,
                              decoration: InputDecoration(
                                  filled: false,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFD5D6D8),
                                      )
                                  )
                              )
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 32.h, 0, 44.h),
                            child: Row(
                              children: [
                                Expanded(
                                    child: SizedBox(
                                        height: 50.h,
                                        child: myButton(MyColor.buttonGrey, Strings.next2, _clickCancel)
                                    )
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                    child: SizedBox(
                                        height: 50.h,
                                        child: myButton(_validity ?MyColor.buttonValidity :Color(0xFF4F60F4), Strings.check, _clickOk)
                                    )
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                    padding: EdgeInsets.only(top: 80.h),
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: _selectImage,
                              child: Container(
                                width: 132.w,
                                height: 132.w,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(3.0, 3.0),
                                      // blurRadius: 10.0,
                                      // spreadRadius: 1.0,
                                    ),
                                  ],
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(100),
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                    image: DecorationImage(
                                      image: _loadImage(),
                                      fit: BoxFit.cover
                                    ),
                                  ),
                                )
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              _user.nickname,
                              style: MyTextStyle.addInfoName,
                            )
                          ],
                        ),
                        Positioned(
                          top: 104.h,
                          right: 7.w,
                          child: InkWell(
                            onTap: _selectImage,
                            child: CircleAvatar(
                                backgroundColor: Color(0xFF4F60F4),
                                radius: 14.w,
                                child: Icon(Icons.camera_alt_outlined, size: 18)
                            ),
                          )
                        )
                      ],
                    )
                )
              ],
            )
          ),
      ),
    );
  }
}
