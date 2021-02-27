import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  fillColor: Color(0xFFEEEEE) ,
  hoverColor: Color(0xFFEEEE),
  focusColor: Color(0xFFEEEE),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Nhập gì đó ...',
  hintStyle: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
    // border: Border(
    //   top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    // ),

    );
