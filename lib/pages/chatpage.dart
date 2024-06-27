import 'package:chat_app/service/database.dart';
import 'package:chat_app/service/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

class ChatPage extends StatefulWidget {
  String name, profileurl, username;
  ChatPage(
      {required this.name, required this.profileurl, required this.username});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController =
      new TextEditingController(); // To control the messages

  // To get my details we used "shredpreference"
  String? myUserName, myProfilePic, myName, myEmail, messageId, chatRoomId;
  getthesharedpref() async {
    myUserName = await SharedPreferenceHelper().getUserName();
    myProfilePic = await SharedPreferenceHelper().getUserPic();
    myName = await SharedPreferenceHelper().getUserDisplayName();
    myEmail = await SharedPreferenceHelper().getUserEmail();
    chatRoomId = getChatRoomIdbyUsername(widget.username, myUserName!);

    // So that we can re-run the app
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    ontheload();
  }

  getChatRoomIdbyUsername(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  // Add message function so that whenever we click on the send button the message should be added

  // To display the upadated message on the screen


  addMessage(bool sendClicked) {
    // Whenever the controller is empty them we can write the message and store it in the message string
    if (messageController.text != "") {
      String message = messageController.text;
      // Now if the user if sends the message then the textfield should get empty and to do so we wrote this
      messageController.text = "";
      // To store the time
      DateTime now = DateTime.now();
      // To format the date accoriding to hour and minute
      String formattedDate = DateFormat('h:mma').format(now);
      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": myUserName,
        // To show the time
        "ts": formattedDate,
        // This will help to show the message according to timespan
        "time": FieldValue.serverTimestamp(),
        "imgUrl": myProfilePic
      };
      messageId ??= randomAlphaNumeric(10);

      DatabaseMethods()
          .addMessage(chatRoomId!, messageId!, messageInfoMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendTs": formattedDate,
          'time': FieldValue.serverTimestamp(),
          "lastMessageSendBy": myUserName,
        };
        DatabaseMethods()
            .updateLastMessageSend(chatRoomId!, lastMessageInfoMap);
        if (sendClicked) {
          messageId = null;
        }
      });
    }
  }
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
                    padding: EdgeInsets.only(
                        top: 20, right: 10, left: 10, bottom: 40),
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
                                      left: MediaQuery.of(context).size.width /
                                          4),
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
                                      right: MediaQuery.of(context).size.width /
                                          4),
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
                                    controller: messageController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter Message",
                                        hintStyle:
                                            TextStyle(color: Colors.black45)),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    addMessage(true);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            31, 169, 169, 169),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Center(
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.black45,
                                      ),
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

