import 'package:flutter/material.dart';

Widget appBar(BuildContext context){
 return AppBar(
   title: Text("Flutter Chat"),
   elevation: 0.0,
   centerTitle: false,
 );
}

InputDecoration textFieldInputDecoration(String hinttext){
  return InputDecoration(
    hintText: hinttext,
    hintStyle: TextStyle(color: Colors.white54),
    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
  );
}

TextStyle simpleTextStyle(){
  return TextStyle(
  color: Colors.white,
  fontSize: 16
  );
}