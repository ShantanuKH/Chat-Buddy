import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:Container(
        child: Container(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.7,
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
                      "SignUp",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    )),
                    Center(
                        child: Text(
                      "Create a new account",
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
                          height: MediaQuery.of(context).size.height / 1.5,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                                // Name
                              Text(
                                "Name",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0, color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextField(
                                  // To remove the border already present which
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.email)),
                                ),
                              ),
                                 SizedBox(
                                height: 20,
                              ),

                              // Email
                              Text(
                                "Email",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0, color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextField(
                                  // To remove the border already present which
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
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0, color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextField(
                                  // To remove the border already present which
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
                            
                              // Confirm Password
                              Text(
                                "Confirm Password",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0, color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextField(
                                  // To remove the border already present which
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.password)),

                                  // To not to show what is written in the text field
                                  obscureText: true,
                                ),
                              ),

                              SizedBox(
                                height: 20,
                              ),
                            

                              //SignIn
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
                                      child: Text("SignIn",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white))),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    RichText(
                      text: TextSpan(
                        text: "Already have an account ?",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        children:[
                          TextSpan(
                              text: ' SignIn ',
                              style: TextStyle(color: Color.fromARGB(255, 1, 151, 185),fontWeight: FontWeight.bold)),
                          
                        ],
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
