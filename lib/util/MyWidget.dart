import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';

showMsg(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

Widget myButton(double width, double height, Color color, String text, onPressed) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
        backgroundColor: color,
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)))),
    child: Text(text, style: TextStyle(color: Colors.white)),
    onPressed: onPressed,
  );
}

makePicker(BuildContext context, TextEditingController controller, String title, int begin) {
  Picker(
      // adapter: NumberPickerAdapter(data: [
      //   NumberPickerColumn(begin: begin, end: DateTime.now().year, jump: 1,
      //   ),
      // ]),
      adapter: PickerDataAdapter<String>(
          pickerdata: _makeData(begin)),
      hideHeader: true,
      selecteds: [begin==1950?40:2], //  시작위치
      title: Center(child:Text(title, style: TextStyle(fontSize: 16, decoration: TextDecoration.underline))),
      selectedTextStyle: TextStyle(fontSize: 30, color: Colors.black),
      textStyle: TextStyle(fontSize: 24, color: Color(0xFFD4D4D4)),
      confirmText: "확인",
      cancelText: "취소",
      height: 100,
      itemExtent: 40,
      onConfirm: (Picker picker, List value) {
        // print(value.toString());
        // print(picker.getSelectedValues());
        controller.text = picker.getSelectedValues().first;
      }).showDialog(context);
}

_makeData(int begin) {
  List<String> array = [];
  for(int i=begin; i<=DateTime.now().year; i++){
    array.add("$i 년");
  }
  return array;
}