import 'package:after_school/common/resources/MyColor.dart';
import 'package:after_school/common/resources/MyTextStyle.dart';
import 'package:after_school/common/resources/Strings.dart';
import 'package:after_school/common/util/MyScreenUtil.dart';
import 'package:after_school/common/widget/MyWidget.dart';
import 'package:flutter/material.dart';

import 'add_school_screen.dart';

class AddNameScreen extends StatefulWidget {
  const AddNameScreen({Key? key, required this.nickname}) : super(key: key);
  final String nickname;

  @override
  State<StatefulWidget> createState() => _AddNameScreenState();
}

class _AddNameScreenState extends State<AddNameScreen> {
  final _nameInputController = TextEditingController();
  bool _validity = false;

  @override
  void initState() {
    super.initState();
    _nameInputController.addListener(_checkValidity);
    _nameInputController.text = widget.nickname;
  }

  @override
  void dispose() {
    _nameInputController.dispose();
    super.dispose();
  }

  _checkValidity() {
    if(_nameInputController.text.isNotEmpty && _nameInputController.text.length >= 2) {
      setState(() {
        _validity = true;
      });
    } else{
      setState(() {
        _validity = false;
      });
    }
  }

  _clickNext() {
    if(_validity) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  AddSchoolScreen(nickname: _nameInputController.text)));
    }else {
      showMsg(context, Strings.addNameMsg1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        //  키보드 밀림 방지
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(Strings.loginTextPage),
          actions: [
            TextButton(
                onPressed: _clickNext,
                child: Text(Strings.next, style: TextStyle(color: Colors.black)))
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
                    const Text(
                      Strings.addNameText1,
                      style: MyTextStyle.bodyTextMedium1,
                    ),
                    Row(
                      children: const [
                        Text(
                          Strings.addNameLabel1,
                          style: MyTextStyle.bodyTextMedium2,
                        ),
                        Text(
                          Strings.addNameText2,
                          style: MyTextStyle.bodyTextMedium1,
                        )
                      ],
                    ),
                  ],
                )),
            Container(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: Text(Strings.addNameLabel2),
                    ),
                    // Row(
                    //   children: [
                    //     Flexible(
                    //       child: TextField(
                    //         controller: _nameInputController,
                    //         maxLines: 1,
                    //         decoration: InputDecoration(
                    //             suffixIcon: Icon(Icons.cancel_outlined)
                    //         ),
                    //       ),
                    //     ),
                    //     IconButton(
                    //       onPressed: () {},
                    //       icon: Icon(Icons.clear),
                    //       iconSize: 30,
                    //       padding: EdgeInsets.all(18),
                    //       color: MyColor.icon,
                    //     )
                    //   ],
                    // ),
                    TextField(
                      controller: _nameInputController,
                      maxLines: 1,
                      decoration: InputDecoration(
                          errorText: _validity ?null :Strings.addNameErrorText,
                          suffixIcon: _validity
                              ?IconButton(
                                onPressed: () => _nameInputController.text = "",
                                icon: Icon(Icons.cancel_outlined),
                              )
                              :Icon(Icons.info, color: Colors.red)
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Text(Strings.addNameText3, style: MyTextStyle.bodyTextAlert)
                    )
                  ],
                )),
            Container(
              padding: EdgeInsets.only(top: 218.h, left: 30.w, right: 30.w),
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
      )
    );
  }
}