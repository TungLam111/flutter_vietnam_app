import 'dart:io';
import 'package:flutter/cupertino.dart';

class ChatUsers {
  String email;
  String text;
  String secondaryText;
  String image;
  String time;
  int countUnread;
  ChatUsers(
      {
        @required  this.email,
        @required this.text,
      @required this.secondaryText,
      @required this.image,
      @required this.time,
      this.countUnread});
}

enum STATE { NONE, ICONMENU, LOADIMAGE, LOADFILE, SHOWREACT }
enum REACTTYPE { ANGRY, LIKE, WOW, SAD, LOVE, HAHA, NONE }

class MessageBubble {
  String msgText;
  String msgSender;
  bool user;
  File image;
  REACTTYPE react;
  int replyIndex;
  String time;
  MessageBubble(
      {this.msgText,
      this.msgSender,
      this.user,
      this.image,
      this.react,
      this.replyIndex,
      this.time});
}

// EXAMPLE MESSAGES IN CHAT SCREEN
List<MessageBubble> messages = [
  MessageBubble(
      user: true,
      msgText: "hi",
      msgSender: "phandamtunglam",
      image: null,
      react: REACTTYPE.ANGRY,
      replyIndex: -1,
      time: "15:30"),
  MessageBubble(
      user: false,
      msgText: "hello",
      msgSender: "tunglamtunglam",
      image: null,
      react: REACTTYPE.LOVE,
      replyIndex: -1,
      time: "15:30"),
  MessageBubble(
      user: false,
      msgText: "hello",
      msgSender: "tunglamtunglam",
      image: null,
      react: REACTTYPE.LOVE,
      replyIndex: -1,
      time: "15:30"),
  MessageBubble(
      user: false,
      msgText: "hello",
      msgSender: "tunglamtunglam",
      image: null,
      react: REACTTYPE.LOVE,
      replyIndex: -1,
      time: "15:30"),
  MessageBubble(
      user: false,
      msgText: "hello",
      msgSender: "tunglamtunglam",
      image: null,
      react: REACTTYPE.LOVE,
      replyIndex: -1,
      time: "15:30"),
  MessageBubble(
      user: false,
      msgText: "hello",
      msgSender: "tunglamtunglam",
      image: null,
      react: REACTTYPE.LOVE,
      replyIndex: -1,
      time: "15:30"),
  MessageBubble(
      user: false,
      msgText: "hello",
      msgSender: "tunglamtunglam",
      image: null,
      react: REACTTYPE.LOVE,
      replyIndex: -1,
      time: "15:30"),
  MessageBubble(
      user: false,
      msgText: "hello",
      msgSender: "tunglamtunglam",
      image: null,
      react: REACTTYPE.LOVE,
      replyIndex: -1,
      time: "15:30"),
  MessageBubble(
      user: false,
      msgText: "hello",
      msgSender: "tunglamtunglam",
      image: null,
      react: REACTTYPE.LOVE,
      replyIndex: -1,
      time: "15:30"),
  MessageBubble(
      user: false,
      msgText: "hello",
      msgSender: "tunglamtunglam",
      image: null,
      react: REACTTYPE.LOVE,
      replyIndex: -1,
      time: "15:30"),
  MessageBubble(
      user: false,
      msgText: "hello",
      msgSender: "tunglamtunglam",
      image: null,
      react: REACTTYPE.LOVE,
      replyIndex: -1,
      time: "15:30"),
  MessageBubble(
      user: false,
      msgText: "hello",
      msgSender: "tunglamtunglam",
      image: null,
      react: REACTTYPE.LOVE,
      replyIndex: -1,
      time: "15:30"),
  MessageBubble(
      user: false,
      msgText: "hello",
      msgSender: "tunglamtunglam",
      image: null,
      react: REACTTYPE.LOVE,
      replyIndex: -1,
      time: "15:30"),
];

class User {
  String name;
  String email;
  String password;

  User({
    this.name,
    this.email,
    this.password,
  });
}
