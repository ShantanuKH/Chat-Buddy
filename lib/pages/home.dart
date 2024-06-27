import 'package:chat_app/pages/chatpage.dart';
import 'package:chat_app/service/database.dart';
import 'package:chat_app/service/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Search Feature in the app

  // bool search = false;

  // // We created two list here as when we will click on search and type any initials then we would get suggestion of the person starting with the specific initial and also the other list for storing the search
  // var queryResultSet = [];
  // var tempSearchStorage = [];

  // initiateSearch(value) {
  //   // If there is nothing in the textfield then there will be nothing means the lists will be empty
  //   if (value.length == 0) {
  //     setState(() {
  //       queryResultSet = [];
  //       tempSearchStorage = [];
  //     });
  //   }
  //   // This other setState is for when user will start typing

  //   setState(() {
  //     search = true;
  //   });
  //   var capitalizedValue =
  //       value.substring(0,1).toUpperCase() + value.substring(1);
  //   if (queryResultSet.length == 0 && value.length == 1) {
  //     DatabaseMethods().Search(value).then((QuerySnapshot docs) {
  //       for (int i = 0; i < docs.docs.length; i++) {
  //         queryResultSet.add(docs.docs[i].data());
  //       }
  //     });
  //   } else {
  //     tempSearchStorage = [];
  //     queryResultSet.forEach((element) {
  //       if (element["username"].startsWith(capitalizedValue)) {
  //         setState(() {
  //           tempSearchStorage.add(element);
  //         });
  //       }
  //     });
  //   }
  // }
  bool search = false;

  String? myName, myProfilePic, myUserName, myEmail;
  Stream? chatRoomStream;

  getthesharedpref() async {
    myName = await SharedPreferenceHelper().getUserDisplayName();
    myProfilePic = await SharedPreferenceHelper().getUserPic();
    myUserName = await SharedPreferenceHelper().getUserName();
    myEmail = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  // To show all the users on the screen
  Widget ChatRoomList() {
    return StreamBuilder(
        stream: chatRoomStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.doc.length;

                  return 
                })
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
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

// We created two lists here: one for the suggestions based on the search query
// and another for storing the search results.
  var queryResultSet = [];
  var tempSearchStorage = [];

  void initiateSearch(String value) {
    // If there is nothing in the textfield, clear the lists.
    if (value.isEmpty) {
      setState(() {
        queryResultSet = [];
        tempSearchStorage = [];
      });
      return;
    }

    // When the user starts typing, set the search flag to true.
    setState(() {
      search = true;
    });

    // Capitalize the first letter of the value.
    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    // If the queryResultSet is empty and the value length is 1, fetch results from the database.
    if (queryResultSet.isEmpty && value.length == 1) {
      DatabaseMethods().Search(value).then((QuerySnapshot docs) {
        setState(() {
          queryResultSet = docs.docs.map((doc) => doc.data()).toList();
        });
      }).catchError((error) {
        // Handle any errors here
        print("Error fetching search results: $error");
      });
    } else {
      // Filter the existing results based on the search query.
      tempSearchStorage = [];
      queryResultSet.forEach((element) {
        if (element["username"].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStorage.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFF7ce8ff),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 15, right: 20, top: 10, bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // If search is true then we will show search tab/field and if false then we will show the "ChatUp Text"
                      search
                          ? Expanded(
                              child: Container(
                                margin: EdgeInsets.all(10.0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6.0,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 1.0,
                                  ),
                                ),
                                child: TextField(
                                  onChanged: (value) {
                                    initiateSearch(value.toUpperCase());
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search User",
                                    hintStyle: TextStyle(
                                      color: Colors.black12,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            )
                          : Text(
                              "ChatUp",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                      GestureDetector(
                        onTap: () {
                          search = true;
                          setState(() {});
                        },
                        child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.blue.shade300,
                                borderRadius: BorderRadius.circular(30)),
                            child: search
                                ? GestureDetector(
                                    onTap: () {
                                      search = false;
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  )
                                : Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  )),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  height: search
                      ? MediaQuery.of(context).size.height / 2.2
                      : MediaQuery.of(context).size.height / 1.16,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      search
                          ? ListView(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              primary: false,
                              shrinkWrap: true,
                              children: tempSearchStorage.map((element) {
                                return buildResultCard(element);
                              }).toList(),
                            )
                          : Column(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 5, right: 10, top: 5, bottom: 5),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          child: Image.asset(
                                            "images/sk2.jpg",
                                            height: 70,
                                            width: 70,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Shantanu Khadse",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                "Hello ! What are you doing ?",
                                                style: TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "03:20 PM",
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 10, top: 5, bottom: 5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(60),
                                        child: Image.asset(
                                          "images/sk1.jpg",
                                          height: 70,
                                          width: 70,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Shantu",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "Hello",
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "08:05 PM",
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget buildResultCard(data) {
    return GestureDetector(
      onTap: () async {
        search = false;
        setState(() {});
        var chatRoomId = getChatRoomIdbyUsername(myUserName!, data['username']);
        Map<String, dynamic> chatRoomInfoMap = {
          "users": [myUserName, data['username']],
        };

        await DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                    name: data["Name"],
                    profileurl: data["Photo"],
                    username: data["username"])));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(
                      data["Photo"],
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data["Name"],
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      data["username"],
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ChatRoomListTiles extends StatefulWidget {
  final String lastMessage,chatRoomId,myUserName,time;
  ChatRoomListTiles({required this.chatRoomId,required this.lastMessage,required this.myUserName,required this.time});

  @override
  State<ChatRoomListTiles> createState() => _ChatRoomListTilesState();
}

class _ChatRoomListTilesState extends State<ChatRoomListTiles> {

  String profilePicUrl="", name="",username="", id="";
  getthisUserInfo(){
    username = widget.chatRoomId.replaceAll("_", "").replaceAll(widget.myUserName, "");
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}