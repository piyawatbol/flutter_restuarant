import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_bs/screen/main_shopkeeper_screen/order_screen/detail_order_screen.dart';
import 'package:my_bs/widget/auto_size_text.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  FirebaseAuth Auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xffC4CFD4),
        title: Text(
          "ออเดอร์",
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
        child: Column(children: [
          buildHead(),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Restaurant")
                    .where("uid", isEqualTo: Auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error : " + snapshot.error.toString());
                  } else if (snapshot.hasData) {
                    List restaurantid = [];
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      restaurantid.add(snapshot.data!.docs[i]['restaurantid']);
                    }
                    return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Order")
                            .where("restaurantid", whereIn: restaurantid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("Error : " + snapshot.error.toString());
                          } else if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return buildOrder(snapshot.data!.docs, index);
                              },
                            );
                          } else {
                            return Text("Loading");
                          }
                        });
                  } else {
                    return Text("Loading");
                  }
                }),
          )
        ]),
      ),
    );
  }

  Widget buildHead() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AutoText(
            width: width * 0.32,
            text: "เลขออเดอร์",
            fontSize: 24,
            color: Colors.black,
            text_align: TextAlign.center,
            fontWeight: null,
          ),
          AutoText(
            width: width * 0.26,
            text: "ชื่ออาหาร",
            fontSize: 24,
            color: Colors.black,
            text_align: TextAlign.center,
            fontWeight: null,
          ),
        ],
      ),
    );
  }

  Widget buildOrder(List doc, index) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return DetailOrderScreen(
            orderList: doc,
            index: index,
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: height * 0.006, horizontal: width * 0.03),
        width: width * 0.9,
        height: height * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Color(0xff8A9EA8),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.018),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            AutoText(
              width: width * 0.45,
              text: "${doc[index]['orderno']}",
              fontSize: 20,
              color: Colors.black,
              text_align: TextAlign.left,
              fontWeight: null,
            ),
            AutoText(
              width: width * 0.4,
              text: "${doc[index]['foodname']}",
              fontSize: 20,
              color: Colors.black,
              text_align: TextAlign.right,
              fontWeight: null,
            ),
          ]),
        ),
      ),
    );
  }
}
