import 'package:chat_app/pages/chatpage.dart';
import 'package:chat_app/service/database.dart';
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

  bool search = false;

  // We created two list here as when we will click on search and type any initials then we would get suggestion of the person starting with the specific initial and also the other list for storing the search
  var queryResultSet = [];
  var tempSearchStorage = [];

  initiateSearch(value) {
    // If there is nothing in the textfield then there will be nothing means the lists will be empty
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStorage = [];
      });
    }
    // This other setState is for when user will start typing

    setState(() {
      search = true;
    });
    var capitalizedValue =
        value.substring(0,1).toUpperCase() + value.substring(1);
    if (queryResultSet.length == 0 && value.length == 1) {
      DatabaseMethods().Search(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; i++) {
          queryResultSet.add(docs.docs[1].data());
        }
      });
    } else {
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
                          topRight: Radius.circular(20))),
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
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatPage()));
                                  },
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                ],
              ),
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
        ),
      ),
    );
  }
}
