import 'package:chat_app/pages/forgotpassword.dart';
import 'package:chat_app/pages/home.dart';
import 'package:chat_app/pages/signup.dart';
import 'package:chat_app/service/database.dart';
import 'package:chat_app/service/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Creating signin feature so that people can signin if they already have an account

  String email = "", password = "", name = "", pic = "", username = "", id = "";
  TextEditingController usermailController = new TextEditingController();

  TextEditingController userpasswordController = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Looks up the user in the "users" collection of the Firestore database where the "Email" matches the given email
      QuerySnapshot querySnapshot =
          await DatabaseMethods().getUserbyEmail(email);

      // querySnapshot.docs[0] gets the first document (user) from the search results.
      name = "${querySnapshot.docs[0]["Name"]}";
      username = "${querySnapshot.docs[0]["username"]}";
      pic = "${querySnapshot.docs[0]["Photo"]}";
      id = querySnapshot.docs[0].id;

      // This will save the users details
      await SharedPreferenceHelper().saveUserDisplayName(name);
      await SharedPreferenceHelper().saveUserName(username);
      await SharedPreferenceHelper().saveUserId(id);
      await SharedPreferenceHelper().saveUserPic(pic);

      // Here, we use pushReplacement instead of just push because if the user would have signed up and if we go to the home page, after clicking on the back button on the home page, the user would come to the signup page which we don't want. So we use Navigator.pushReplacement
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No user found",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong password",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Container(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 4.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(

                    // To give the radient color to our project
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(61, 182, 229, 1),
                      Color(0xFF7ce8ff)
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),

                    // This will make the radius curve from bottom
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 105.5))),
              ),
              Padding(
                padding: EdgeInsets.only(top: 70),
                child: Column(
                  children: [
                    Center(
                        child: Text(
                      "SignIn",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    )),
                    Center(
                        child: Text(
                      "Login to your account",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                    )),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Email
                                Text(
                                  "Email",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.0, color: Colors.black),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextFormField(
                                    // To remove the border already present which
                                    controller: usermailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please Enter Your E-mail";
                                      }
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.email)),
                                  ),
                                ),
                                // Password
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Password",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.0, color: Colors.black),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextFormField(
                                    // To remove the border already present which
                                    controller: userpasswordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please Enter Your Password";
                                      }
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.key)),

                                    // To not to show what is written in the text field
                                    obscureText: true,
                                  ),
                                ),

                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPassword()),
                                    );
                                  },
                                  child: Container(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        "Forgot Password ?",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      )),
                                ),

                                //SignIn
                                SizedBox(
                                  height: 80,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (_formkey.currentState!.validate()) {
                                      setState(() {
                                        email = usermailController.text;
                                        password = userpasswordController.text;
                                      });
                                    }
                                    userLogin();
                                  },
                                  child: Center(
                                    child: Material(
                                      elevation: 10,
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              top: 10,
                                              bottom: 10,
                                              right: 20,
                                              left: 20),
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 16, 193, 228),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text("SignIn",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white))),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()),
                              );
                            },
                            child: Text(
                              'SignUp',
                              style: TextStyle(
                                color: Color.fromARGB(255, 1, 151, 185),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
