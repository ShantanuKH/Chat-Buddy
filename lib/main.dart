import 'package:chat_app/pages/chatpage.dart';
import 'package:chat_app/pages/home.dart';
import 'package:chat_app/pages/signin.dart';
import 'package:chat_app/pages/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
 
      home: const ChatPage(),
    );
  }
}
