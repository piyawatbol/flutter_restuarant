import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_bs/screen/home.dart';
import 'package:my_bs/screen/main_shopkeeper_screen/food_screen/edit_food_screen.dart';
import 'package:my_bs/screen/main_teacher_screen/addmoney.dart';
import 'package:my_bs/widget/auto_size_text.dart';

class Profile_Teacher extends StatefulWidget {
  const Profile_Teacher({super.key});

  @override
  State<Profile_Teacher> createState() => _Profile_TeacherState();
}

class _Profile_TeacherState extends State<Profile_Teacher> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: buildDrawer(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xffC4CFD4),
        title: Text(
          "หน้าหลัก",
          style: GoogleFonts.mitr(
            textStyle: TextStyle(
              color: Color(0xff576B75),
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Container(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildSteam(),
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: height * 0.01),
              //   child: AutoText(
              //     width: width * 0.5,
              //     text: "ปรับแต่งอาหารของฉัน",
              //     fontSize: 24,
              //     color: Colors.black,
              //     text_align: TextAlign.center,
              //     fontWeight: null,
              //   ),
              // ),
              // buildStore()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDrawer() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: Color(0xffD9D9D9),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .where("uid", isEqualTo: auth.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return Text("Something went wrong");
          } else {
            Widget test = snapshot.data!.docs
                .map((doc) => Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: width * 0.08,
                                  backgroundImage:
                                      NetworkImage("${doc['userimg']}"),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.03,
                                      vertical: height * 0.025),
                                  width: width * 0.53,
                                  // height: height * 0.11,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoText(
                                        width: width * 0.5,
                                        text:
                                            "ชื่อ : ${doc['name']} ${doc['lname']}",
                                        fontSize: 14,
                                        color: Colors.black,
                                        text_align: TextAlign.left,
                                        fontWeight: null,
                                      ),
                                      AutoText(
                                        width: width * 0.5,
                                        text: "รหัสอาจารณ์ : ${doc['id']}",
                                        fontSize: 14,
                                        color: Colors.black,
                                        text_align: TextAlign.left,
                                        fontWeight: null,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          ListTile(
                            title: const Text('LOGIN'),
                            onTap: () {},
                          ),
                          ListTile(
                            title: const Text('LOGOUT'),
                            onTap: () {
                              FirebaseAuth.instance.signOut().then((value) {
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                  return HomeScreen();
                                }), (v) {
                                  return false;
                                });
                              });
                            },
                          ),
                        ],
                      ),
                    ))
                .first;
            return Container(
              height: 500,
              child: test,
            );
          }
        },
      ),
    );
  }

  Widget buildSteam() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.5,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .where("uid", isEqualTo: auth.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return Text("Something went wrong");
          } else {
            Widget test = snapshot.data!.docs
                .map((doc) => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: height * 0.01,
                              horizontal: width * 0.03),
                          child: Row(
                            children: [
                              AutoText(
                                width: width * 0.28,
                                text: "ข้อมูลส่วนตัว",
                                fontSize: 20,
                                color: Colors.black,
                                text_align: TextAlign.left,
                                fontWeight: null,
                              ),
                            ],
                          ),
                        ),
                        buildProfile(doc),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * 0.02),
                                  child: AutoText(
                                    width: width * 0.3,
                                    text: " ",
                                    fontSize: 24,
                                    color: Colors.black,
                                    text_align: TextAlign.center,
                                    fontWeight: null,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("test");
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return addmoney();
                                      },
                                    ));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: width * 0.4,
                                    height: height * 0.1,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Color(0xff8A9EA8))),
                                    child: Center(
                                      child: AutoText(
                                        width: width * 0.6,
                                        text: "ระบบเติมเงิน",
                                        fontSize: 40,
                                        color: Colors.black,
                                        text_align: TextAlign.center,
                                        fontWeight: null,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * 0.02),
                                  child: AutoText(
                                    width: width * 0.3,
                                    text: "กระเป๋าตัง",
                                    fontSize: 24,
                                    color: Colors.black,
                                    text_align: TextAlign.center,
                                    fontWeight: null,
                                  ),
                                ),
                                Container(
                                  width: width * 0.4,
                                  height: height * 0.1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border:
                                          Border.all(color: Color(0xff8A9EA8))),
                                  child: Center(
                                    child: AutoText(
                                      width: width * 0.6,
                                      text: "${doc['wallet']} บาท",
                                      fontSize: 28,
                                      color: Colors.black,
                                      text_align: TextAlign.center,
                                      fontWeight: null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ))
                .first;
            return Container(
              height: 500,
              child: test,
            );
          }
        },
      ),
    );
  }

  Widget buildStore() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Restaurant")
            .where("type", isEqualTo: "ร้านข้าว")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error" + snapshot.error.toString());
          } else if (snapshot.hasData) {
            return Container(
              height: height * 0.3,
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return EditFoodScreen(
                          restaurantid: snapshot.data!.docs[index]
                              ['restaurantid'],
                        );
                      }));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: width * 0.01, vertical: height * 0.003),
                      width: width,
                      height: height * 0.13,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Color(0xff8A9EA8))),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AutoText(
                                width: width * 0.4,
                                text: snapshot.data!.docs[index]['name'],
                                fontSize: 18,
                                color: Colors.black,
                                text_align: TextAlign.left,
                                fontWeight: null,
                              ),
                              Image.asset("assets/images/store.png")
                            ]),
                      ),
                    ),
                  );
                },
              ),
            );
            // print(snapshot.data!.docs[0]['type']);
          } else {
            return Text("Loading");
          }
        });
  }

  Widget buildProfile(doc) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.01, horizontal: width * 0.04),
      child: Row(
        children: [
          CircleAvatar(
            radius: width * 0.12,
            backgroundImage: NetworkImage("${doc['userimg']}"),
          ),
          Container(
            padding: EdgeInsets.all(20),
            width: width * 0.67,
            // height: height * 0.12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoText(
                  width: width * 0.7,
                  text: "รหัสอาจารณ์ : ${doc['id']}",
                  fontSize: 16,
                  color: Colors.black,
                  text_align: TextAlign.left,
                  fontWeight: null,
                ),
                AutoText(
                  width: width * 0.7,
                  text: "ชื่อ : ${doc['name']} ${doc['lname']}",
                  fontSize: 16,
                  color: Colors.black,
                  text_align: TextAlign.left,
                  fontWeight: null,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
