import 'package:chat_app/pages/home.dart';
import 'package:chat_app/service/database.dart';
import 'package:chat_app/service/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", password = "", name = "", confirmPassword = "";
  TextEditingController mailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController confirmPasswordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null && password == confirmPassword) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String Id = randomAlphaNumeric(10);

        Map<String, dynamic> userInfoMap = {
          "Name": namecontroller.text,
          "Email": mailcontroller.text,
          "username": mailcontroller.text.replaceAll("@gmail.com", ""),
          "Photo": "https://images.app.goo.gl/CYS1ipQbwLJfd6ZdA",
          "Id": Id
        };

        await DatabaseMethods().addUSerDetails(userInfoMap, Id);

        await SharedPreferenceHelper().saveUserId(Id);
        await SharedPreferenceHelper().saveUserDisplayName(namecontroller.text);
        await SharedPreferenceHelper().saveUserEmail(mailcontroller.text);
        await SharedPreferenceHelper()
            .saveUserPic("https://images.app.goo.gl/CYS1ipQbwLJfd6ZdA");
        await SharedPreferenceHelper()
            .saveUserName(mailcontroller.text.replaceAll("@gmail.com", ""));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Registered Successfully",
              style: TextStyle(fontSize: 20),
            ),
          ),
        );

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Use a strong password",
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account already exists",
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Registration failed: $e",
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Passwords do not match",
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.7,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(61, 182, 229, 1),
                    Color(0xFF7ce8ff)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                      MediaQuery.of(context).size.width, 105.5),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 70),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Create a new account",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name",
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
                                    controller: namecontroller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Name';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.person)),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
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
                                    controller: mailcontroller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Email';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.email)),
                                  ),
                                ),
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
                                    controller: passwordcontroller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Password';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.key)),
                                    obscureText: true,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Confirm Password",
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
                                    controller: confirmPasswordcontroller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Confirm Password';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.password)),
                                    obscureText: true,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 80,
                                ),
                                Center(
                                  child: Material(
                                    elevation: 10,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          right: 20,
                                          left: 20),
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 16, 193, 228),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text("SignUp",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            email = mailcontroller.text;
                            name = namecontroller.text;
                            password = passwordcontroller.text;
                            confirmPassword =
                                confirmPasswordcontroller.text;
                          });
                          registration();
                        }
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account ?",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          children: [
                            TextSpan(
                              text: ' SignUp ',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 1, 151, 185),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
