import 'package:chat_app/pages/chatpage.dart';
import 'package:chat_app/pages/forgotpassword.dart';
import 'package:chat_app/pages/home.dart';
import 'package:chat_app/pages/signin.dart';
import 'package:chat_app/pages/signup.dart';
import 'package:chat_app/service/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // To initialize firebase core function
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        home: FutureBuilder(
          future:AuthMethods().getcurrentUser() ,
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return SignUp();
            }
          },
        ));
  }
}
