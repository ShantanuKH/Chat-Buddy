import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {

  String name, profileurl, username;
  ChatPage({required this.name, required this.profileurl, required this.username});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(197, 11, 164, 234),
        body: Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 68,
                    ),
                    Text(
                      "Shantanu Khadse",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 40),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    top: 15, left: 12, right: 10, bottom: 15),
                                margin: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 4),
                                alignment: Alignment.bottomRight,
                                decoration: BoxDecoration(
                                  color: Color(0xFF7ce8ff),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Text(
                                  "Hello! How are you? Are you okay?",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.only(
                                    top: 15, left: 12, right: 10, bottom: 15),
                                margin: EdgeInsets.only(
                                    right:
                                        MediaQuery.of(context).size.width / 4),
                                alignment: Alignment.bottomLeft,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Text(
                                  "I am fine! Tell me about yourself. How are you doing?",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Material(
                        elevation: 7,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 15, top: 5, bottom: 5, right: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter Message",
                                      hintStyle:
                                          TextStyle(color: Colors.black45)),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(31, 169, 169, 169),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Center(
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.black45,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
