import 'package:after_school/resources/MyTextStyle.dart';
import 'package:after_school/util/MyScreenUtil.dart';
import 'package:flutter/material.dart';

import '../resources/Strings.dart';

class InputInstarScreen extends StatelessWidget {
  const InputInstarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _instarInputController = TextEditingController();

    _InputCompletion() {
      Navigator.of(context).pop(_instarInputController.text);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(Strings.addInstarTitle, style: MyTextStyle.inputInstarTitle),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          TextButton(
              onPressed: _InputCompletion,
              child: Text(Strings.completion,
                  style: MyTextStyle.inputInstarAction)
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Container(
                color: Colors.black,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30.w, 221.h, 30.w, 0),
                  child: TextField(
                    controller: _instarInputController,
                    style: MyTextStyle.inputInstarField,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () => _instarInputController.text = "",
                          icon: Icon(Icons.clear, color: Colors.white),
                        ),
                        filled: false,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0x50FFFFFF)
                            )
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0x50FFFFFF)
                            )
                        ),
                    ),
                  ),
                )
            )
        ),
        // FractionallySizedBox(
        //   heightFactor: 1,
        //   widthFactor: 1,
        //   child: Container(
        //     color: Colors.black,
        //     child: Text("Z"),
        //   ),
        // ),

      )
    );
  }

}