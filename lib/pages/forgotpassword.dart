import 'package:chat_app/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // On clicking on the send email user will get the link of firebase in their email which is entered in the textfield by the user and by doing so user can recover their their password
  // User will be redirected to the page were they can reassign the new password
  String email = "";
  final _formkey = GlobalKey<FormState>();

  TextEditingController usermailController = new TextEditingController();

  // function to reset the password

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Password Reset Email has been sent.",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.blue,
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 8),
      Text(
        "Please check your Email!",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  ),
)
));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("User Not Found !", style: TextStyle(fontSize: 18))));
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
                      "Password Recovery",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    )),
                    Center(
                        child: Text(
                      "Enter Your Email",
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
                          height: MediaQuery.of(context).size.height / 3,
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

                                //SignIn
                                SizedBox(
                                  height: 80,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (_formkey.currentState!.validate()) {
                                      setState(() {
                                        email = usermailController.text;
                                      });
                                      resetPassword();
                                    }
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
                                          child: Text("Send Email",
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Want to SignUp ?",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          children: [
                            TextSpan(
                              text: ' SignUp Now!',
                              style: TextStyle(
                                color: Color.fromARGB(255, 1, 151, 185),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
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
