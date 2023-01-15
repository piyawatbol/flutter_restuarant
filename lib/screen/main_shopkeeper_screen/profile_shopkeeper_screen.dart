import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_bs/screen/home.dart';
import 'package:my_bs/screen/main_shopkeeper_screen/food_screen/edit_food_screen.dart';
import 'package:my_bs/screen/main_shopkeeper_screen/order_screen/order_screen.dart';
import 'package:my_bs/screen/main_shopkeeper_screen/store_screen/add_store.dart';
import 'package:my_bs/widget/auto_size_text.dart';

import 'water_screen/edit_water_screen.dart';

class ProfileShopkeeperScreen extends StatefulWidget {
  const ProfileShopkeeperScreen({super.key});

  @override
  State<ProfileShopkeeperScreen> createState() =>
      _ProfileShopkeeperScreenState();
}

class _ProfileShopkeeperScreenState extends State<ProfileShopkeeperScreen> {
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return AddStoreScreen();
                }));
              },
              icon: Icon(Icons.add_home))
        ],
      ),
      body: Container(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildSteam(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.01),
                child: AutoText(
                  width: width * 0.5,
                  text: "ปรับแต่งอาหารของฉัน",
                  fontSize: 24,
                  color: Colors.black,
                  text_align: TextAlign.center,
                  fontWeight: null,
                ),
              ),
              buildStore()
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
                                        text: "รหัสเจ้าของร้าน : ${doc['id']}",
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
                            title: const Text('ORDER'),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return OrderScreen();
                              }));
                            },
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
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.02),
                          child: AutoText(
                            width: width * 0.3,
                            text: "ยอดรายรับ 1 วัน",
                            fontSize: 24,
                            color: Colors.black,
                            text_align: TextAlign.center,
                            fontWeight: null,
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("Restaurant")
                                .where("uid", isEqualTo: auth.currentUser!.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Container(
                                  width: width * 0.9,
                                  child: Text("Something worng!"),
                                );
                              } else if (snapshot.hasData) {
                                List restaurantid = [];
                                for (int i = 0;
                                    i < snapshot.data!.docs.length;
                                    i++) {
                                  print(snapshot.data!.docs[i].data());
                                  restaurantid.add(
                                      snapshot.data!.docs[i]['restaurantid']);
                                }

                                return snapshot.data!.docs.length == 0
                                    ? Container(
                                        width: width * 0.9,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Color(0xff8A9EA8))),
                                        child: Center(
                                          child: AutoText(
                                            width: width * 0.6,
                                            text: "0.0 บาท",
                                            fontSize: 40,
                                            color: Colors.black,
                                            text_align: TextAlign.center,
                                            fontWeight: null,
                                          ),
                                        ),
                                      )
                                    : StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("Order")
                                            .where("restaurantid",
                                                whereIn: restaurantid)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            return Container(
                                              width: width * 0.9,
                                              child: Text("Something worng!"),
                                            );
                                          } else if (snapshot.hasData) {
                                            double profit = 0;
                                            for (int i = 0;
                                                i < snapshot.data!.docs.length;
                                                i++) {
                                              profit += double.parse(snapshot
                                                  .data!.docs[i]['price']);
                                            }
                                            return Container(
                                              width: width * 0.9,
                                              // height: height * 0.25,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color:
                                                          Color(0xff8A9EA8))),
                                              child: Center(
                                                child: AutoText(
                                                  width: width * 0.6,
                                                  text: "${profit} บาท",
                                                  fontSize: 40,
                                                  color: Colors.black,
                                                  text_align: TextAlign.center,
                                                  fontWeight: null,
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Container(
                                              width: width * 0.9,
                                              child: Text("Loading"),
                                            );
                                          }
                                        });
                              } else {
                                return Container(
                                  width: width * 0.9,
                                  child: Text("Loading"),
                                );
                              }
                            }),
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
            .where("uid", isEqualTo: auth.currentUser!.uid)
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
                      if (snapshot.data!.docs[index]['type'] == "ร้านข้าว") {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return EditFoodScreen(
                            restaurantid: snapshot.data!.docs[index]
                                ['restaurantid'],
                          );
                        }));
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return EditWaterScreen(
                            restaurantid: snapshot.data!.docs[index]
                                ['restaurantid'],
                          );
                        }));
                      }
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
                              Image.network(
                                  snapshot.data!.docs[index]['store_img'])
                            ]),
                      ),
                    ),
                  );
                },
              ),
            );
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
                  text: "รหัสเจ้าของร้าน : ${doc['id']}",
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
