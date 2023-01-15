// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_bs/widget/auto_size_text.dart';

class DetailOrderScreen extends StatefulWidget {
  List orderList;
  int? index;
  DetailOrderScreen({required this.orderList, required this.index});

  @override
  State<DetailOrderScreen> createState() => _DetailOrderScreenState();
}

class _DetailOrderScreenState extends State<DetailOrderScreen> {
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
          "ยอดรายการอาหาร",
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
        child: Column(
          children: [
            buildNumberOrder(),
            buildLine(),
            buildTitle("ชื่อ-นามสกุล", "ระดับชั้น"),
            Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .where("uid",
                          isEqualTo: widget.orderList[widget.index!]['uid'])
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error : " + snapshot.error.toString());
                    } else if (snapshot.hasData) {
                      return buildName(snapshot.data!.docs[0]['name'],
                          snapshot.data!.docs[0]['class']);
                    } else {
                      return Text("Loading");
                    }
                  }),
            ),
            buildLine(),
            buildTitle("รายการอาหาร", "ราคา"),
            Container(
              height: height * 0.18,
              child: Row(
                children: [
                  Container(
                    width: width * 0.5,
                    child: ListView.builder(
                      itemCount:
                          widget.orderList[widget.index!]['foodname'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildFood(
                            "${widget.orderList[widget.index!]['foodname'][index]}",
                            "${widget.orderList[widget.index!]['price']}");
                      },
                    ),
                  ),
                  Container(
                    height: height * 0.18,
                    width: width * 0.5,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AutoText(
                          width: width * 0.2,
                          text: "${widget.orderList[widget.index!]['price']}",
                          fontSize: 24,
                          color: Colors.black,
                          text_align: TextAlign.right,
                          fontWeight: null,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            buildLine(),
            buildTitle("เวลาการซื้อขาย", ""),
            buildTime(),
            AutoText(
              width: width,
              text: "รายละเอียดเพิ่มเติม",
              fontSize: 24,
              color: Colors.black,
              text_align: TextAlign.center,
              fontWeight: FontWeight.normal,
            ),
            AutoText(
              width: width,
              text: "${widget.orderList[widget.index!]['detail']}",
              fontSize: 24,
              color: Colors.black,
              text_align: TextAlign.left,
              fontWeight: FontWeight.w300,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNumberOrder() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AutoText(
            width: width * 0.3,
            text: "เลขออเดอร์",
            fontSize: 22,
            color: Colors.black,
            text_align: TextAlign.left,
            fontWeight: null,
          ),
          AutoText(
            width: width * 0.5,
            text: "${widget.orderList[widget.index!]['orderno']}",
            fontSize: 20,
            color: Colors.black,
            text_align: TextAlign.right,
            fontWeight: null,
          ),
        ],
      ),
    );
  }

  Widget buildLine() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.005),
      height: height * 0.012,
      width: width * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Color(0xff8A9EA8),
        ),
      ),
    );
  }

  Widget buildTitle(String title1, String title2) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoText(
            width: width * 0.37,
            text: "$title1",
            fontSize: 24,
            color: Colors.black,
            text_align: TextAlign.left,
            fontWeight: null,
          ),
          AutoText(
            width: width * 0.22,
            text: "$title2",
            fontSize: 24,
            color: Colors.black,
            text_align: TextAlign.right,
            fontWeight: null,
          ),
        ],
      ),
    );
  }

  Widget buildName(String name, String _class) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoText(
            width: width * 0.58,
            text: "$name",
            fontSize: 24,
            color: Colors.black,
            text_align: TextAlign.left,
            fontWeight: null,
          ),
          AutoText(
            width: width * 0.2,
            text: "$_class",
            fontSize: 24,
            color: Colors.black,
            text_align: TextAlign.right,
            fontWeight: null,
          ),
        ],
      ),
    );
  }

  Widget buildFood(String food, String price) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoText(
            width: width * 0.4,
            text: "$food",
            fontSize: 24,
            color: Colors.black,
            text_align: TextAlign.left,
            fontWeight: null,
          ),
          // AutoText(
          //   width: width * 0.2,
          //   text: "$price",
          //   fontSize: 24,
          //   color: Colors.black,
          //   text_align: TextAlign.right,
          //   fontWeight: null,
          // ),
        ],
      ),
    );
  }

  Widget buildTime() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    DateTime date = widget.orderList[widget.index!]['date'].toDate();
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    String formattedtime = DateFormat('kk:mm:ss').format(date);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AutoText(
          width: width * 0.3,
          text: "${formattedtime}",
          fontSize: 24,
          color: Colors.black,
          text_align: TextAlign.left,
          fontWeight: null,
        ),
        AutoText(
          width: width * 0.4,
          text: "${formattedDate}",
          fontSize: 24,
          color: Colors.black,
          text_align: TextAlign.left,
          fontWeight: null,
        ),
      ],
    );
  }
}
