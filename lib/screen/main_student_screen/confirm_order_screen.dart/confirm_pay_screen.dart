// ignore_for_file: unused_local_variable


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_bs/screen/main_student_screen/confirm_order_screen.dart/queue_screen.dart';
import 'package:my_bs/widget/auto_size_text.dart';

class ConfirmPayScreen extends StatefulWidget {
  final restaurantid;
  final List foodid;
  final List foodlist;
  final List foodprice;
  final List foodtype;
  final String fooddetail;
  final String mode;
  ConfirmPayScreen(
      {Key? key,
      required this.foodid,
      required this.foodlist,
      required this.foodprice,
      required this.foodtype,
      required this.fooddetail,
      required this.restaurantid,
      required this.mode})
      : super(key: key);

  @override
  State<ConfirmPayScreen> createState() => _ConfirmPayScreenState();
}

class _ConfirmPayScreenState extends State<ConfirmPayScreen> {
  final auth = FirebaseAuth.instance;
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
          "ยืนยันการชำระเงิน",
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
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.07,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/food2.png"),
                        ],
                      ),
                    ),
                    buildCount(),
                    Container(
                      height: height * 0.2,
                      child: ListView.builder(
                        itemCount: widget.foodid.length,
                        itemBuilder: (context, index) {
                          return buildRowText(widget.foodlist[index],
                              widget.foodprice[index].toString());
                        },
                      ),
                    ),
                    buildResult(),
                    AutoText(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: null,
                      text: 'หมายเหตุ : ระบบจะตัดยอดเข้าร้านเลย',
                      text_align: TextAlign.left,
                      width: width * 0.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [buildConfirmButton(), buildCancelButton()],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCount() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoText(
            width: width * 0.5,
            text: "ข้าวราดแกง",
            fontSize: 24,
            color: Colors.black,
            text_align: TextAlign.left,
            fontWeight: null,
          ),
          AutoText(
            width: width * 0.3,
            text: "จำนวน  ${widget.foodid.length}",
            fontSize: 24,
            color: Colors.black,
            text_align: TextAlign.right,
            fontWeight: null,
          ),
        ],
      ),
    );
  }

  Widget buildRowText(String? text, String? price) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.002),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoText(
            width: width * 0.5,
            text: "$text",
            fontSize: 16,
            color: Colors.black,
            text_align: TextAlign.left,
            fontWeight: null,
          ),
          AutoText(
            width: width * 0.1,
            text: widget.mode == "water" ? "$price" : "",
            fontSize: 16,
            color: Colors.black,
            text_align: TextAlign.right,
            fontWeight: null,
          ),
        ],
      ),
    );
  }

  Widget buildResult() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoText(
            width: width * 0.24,
            text: "ยอดรวม",
            fontSize: 24,
            color: Colors.black,
            text_align: TextAlign.left,
            fontWeight: null,
          ),
          AutoText(
            width: width * 0.2,
            text: widget.mode == "water"
                ? "${(widget.foodprice.reduce((value, element) => value + element)).toString()} บาท"
                : widget.foodid.length > 2
                    ? "35.0 บาท"
                    : "30.0 บาท",
            fontSize: 24,
            color: Colors.black,
            text_align: TextAlign.right,
            fontWeight: null,
          ),
        ],
      ),
    );
  }

  Widget buildConfirmButton() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.04),
      width: width * 0.35,
      height: height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black87,
          backgroundColor: Colors.green,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        onPressed: () async {
          await FirebaseFirestore.instance
              .collection("Users")
              .where("uid", isEqualTo: auth.currentUser!.uid)
              .get()
              .then((uv) async {
            print(uv.docs.first['wallet']);
            int pricer = 0;
            if (widget.mode == "water") {
              pricer =
                  widget.foodprice.reduce((value, element) => value + element);
            } else {
              if (widget.foodid.length > 2) {
                pricer = 35;
              } else {
                pricer = 30;
              }
            }
            if (double.parse(uv.docs.first['wallet']) > pricer) {
              // print("pass");
              await FirebaseFirestore.instance
                  .collection("Users")
                  .doc(uv.docs.first.reference.path.split("/").last)
                  .update({
                "wallet":
                    (double.parse(uv.docs.first['wallet']) - pricer).toString()
              }).then((value) async {
                try {
                  var orderqueue = await FirebaseFirestore.instance
                      .collection("Order")
                      .where("restaurantid", isEqualTo: widget.restaurantid)
                      // .where("foodid", isEqualTo: widget.foodid.toString())
                      .get()
                      .then((value) async {
                    await FirebaseFirestore.instance
                        .collection("Order")
                        .doc()
                        .set({
                      "orderno": DateFormat('yMdHms').format(DateTime.now()),
                      "orderstatus": "0",
                      "queue": value.docs.length + 1,
                      "detail": widget.fooddetail,
                      "restaurantid": widget.restaurantid,
                      "price": pricer,
                      "date": Timestamp.fromDate(DateTime.now()),
                      "foodname": widget.foodlist,
                      "foodtype": widget.foodtype,
                      "foodid": widget.foodid,
                      "uid": auth.currentUser!.uid,
                    }).then((v) async {
                      for (int i = 0; i < widget.foodid.length; i++) {
                        await FirebaseFirestore.instance
                            .collection("Food")
                            .doc(widget.foodid[i])
                            .get()
                            .then((food) async {
                          // print(food.data());
                          await FirebaseFirestore.instance
                              .collection("Food")
                              .doc(widget.foodid[i])
                              .update({"qty": food['qty'] - 1});
                        });
                      }

                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return QueueScreen(
                          queue: value.docs.length + 1,
                          restaurantid: widget.restaurantid,
                        );
                      }));
                    });
                  });
                } catch (e) {
                  print(e);
                }
                try {
                  await FirebaseFirestore.instance
                      .collection("Restaurant")
                      .where("restaurantid", isEqualTo: widget.restaurantid)
                      .get()
                      .then((value) async {
                    await FirebaseFirestore.instance
                        .collection("Users")
                        .where("uid", isEqualTo: value.docs.first['uid'])
                        .get()
                        .then((v) {
                      FirebaseFirestore.instance
                          .collection("Users")
                          .doc(v.docs.first.reference.path.split("/").last)
                          .update({
                        "wallet":
                            (double.parse(v.docs.first['wallet']) + pricer)
                                .toString()
                      });
                    });
                  });
                } catch (e) {
                  print(e);
                }
              });
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("จำนวนเงินในกระเป๋าตังไม่เพียงพอ"),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("ตกลง"),
                      )
                    ],
                  );
                },
              );
            }
          });
        },
        child: AutoText(
          color: Colors.white,
          fontSize: 16,
          fontWeight: null,
          text: 'ยืนยันการชำระเงิน',
          text_align: TextAlign.center,
          width: width * 0.3,
        ),
      ),
    );
  }

  Widget buildCancelButton() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.04),
      width: width * 0.3,
      height: height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black87,
          backgroundColor: Colors.red,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        onPressed: () async {
          Navigator.pop(context);
        },
        child: AutoText(
          color: Colors.white,
          fontSize: 16,
          fontWeight: null,
          text: 'ยกเลิก',
          text_align: TextAlign.center,
          width: width * 0.2,
        ),
      ),
    );
  }
}
