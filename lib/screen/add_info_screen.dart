import 'package:after_school/model/state.dart';
import 'package:after_school/model/user.dart';
import 'package:after_school/resources/MyColor.dart';
import 'package:after_school/resources/MyTextStyle.dart';
import 'package:after_school/resources/Strings.dart';
import 'package:after_school/util/MyScreenUtil.dart';
import 'package:after_school/util/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class AddInfoScreen extends StatefulWidget {
  const AddInfoScreen({Key? key}) : super(key: key);

  @override
  _AddInfoScreenState createState() => _AddInfoScreenState();
}

class _AddInfoScreenState extends State<AddInfoScreen> {
  late User _user;

  @override
  void initState() {
    super.initState();

    _user = context.read<UserState>().user.first;
    print(_user.image);
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nameInputController = TextEditingController();
    final ScrollController _scrollController = ScrollController();

    _clickNext() {
      //  이전 페이지 제거 후 이동
      Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent //상태바 투명
            ),
            backgroundColor: MyColor.loginYello,
            title: Text(Strings.addSchoolPage),
            iconTheme: IconThemeData(color: Colors.white),
            actions: [
              TextButton(
                  onPressed: _clickNext,
                  child: Text(Strings.completion,
                      style: TextStyle(color: Colors.black)))
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
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
                          TextField(
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
                            padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 24.h),
                            child: Text(Strings.addInfoJob, style: MyTextStyle.addInfoBodyLabel),
                          ),
                          TextField(
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
                              maxLines: 5,
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
                                      child: myButton(MyColor.buttonGrey, "다음에", (){})
                                    )
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                    child: SizedBox(
                                      height: 50.h,
                                      child: myButton(Color(0xFF4F60F4), "확인", (){})
                                    )
                                ),
                                // myButton(158.w, 50.h, MyColor.buttonGrey, "다음에", (){}),
                                // myButton(158.w, 50.h, Color(0xFF4F60F4), "확인", (){})
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 80.h),
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 66.w,
                            child: CircleAvatar(
                              radius: 63.w,
                              backgroundImage: NetworkImage(_user.image),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            _user.nickname,
                            style: MyTextStyle.addInfoName,
                          )
                        ],
                      ),
                      Positioned(
                        top: 104.h,
                        right: 7.w,
                        child: CircleAvatar(
                            backgroundColor: Color(0xFF4F60F4),
                            radius: 14.w,
                            child: Icon(Icons.camera_alt_outlined, size: 18)),
                      )
                    ],
                  )
              )
            ],
          )),
    );
  }
}
