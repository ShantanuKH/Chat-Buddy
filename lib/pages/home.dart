import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  padding: EdgeInsets.only(left: 15, right: 20, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ChatUp",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade300,
                              borderRadius: BorderRadius.circular(30)),
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.18,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(60),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Shantanu Khadse",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "Hello ! What are you doing ?",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
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
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                )
              ],
            ),
          ),
        ));
  }
}
