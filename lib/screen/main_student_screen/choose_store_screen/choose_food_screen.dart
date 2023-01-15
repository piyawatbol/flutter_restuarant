import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_bs/screen/main_student_screen/confirm_order_screen.dart/confirm_order_screen.dart';
import 'package:my_bs/widget/auto_size_text.dart';

class ChooseFoodScreen extends StatefulWidget {
  final restaurantid;
  const ChooseFoodScreen({super.key, this.restaurantid});

  @override
  State<ChooseFoodScreen> createState() => _ChooseFoodScreenState();
}

class _ChooseFoodScreenState extends State<ChooseFoodScreen> {
  String type = "";
  List foodtype = List.generate(999, (index) => "");
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
          "เลือกอาหาร",
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
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.23, vertical: height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AutoText(
                      width: width * 0.15,
                      text: "ใส่ถ้วย",
                      fontSize: 16,
                      color: Colors.black,
                      text_align: TextAlign.left,
                      fontWeight: null,
                    ),
                    AutoText(
                      width: width * 0.15,
                      text: "ราดข้าว",
                      fontSize: 16,
                      color: Colors.black,
                      text_align: TextAlign.left,
                      fontWeight: null,
                    ),
                  ],
                ),
              ),
              buildFood(),
              buildCartButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFood() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Food")
            .where("restaurantid", isEqualTo: widget.restaurantid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return Text("Error" + snapshot.error.toString());
          } else if (snapshot.hasData) {
            return Container(
              height: height * 0.72,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: snapshot.data!.docs[index]['qty'] == 0 ||
                            snapshot.data!.docs[index]['qty'] == null
                        ? BoxDecoration(
                            color: Colors.grey, border: Border.all(width: 2.0))
                        : BoxDecoration(color: Colors.white),
                    padding: EdgeInsets.fromLTRB(20, 20, 15, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Opacity(
                          opacity: snapshot.data!.docs[index]['qty'] == 0 ||
                                  snapshot.data!.docs[index]['qty'] == null
                              ? 0.5
                              : 1,
                          child: AutoText(
                            width: width * 0.4,
                            text: snapshot.data!.docs[index]['name'],
                            fontSize: 18,
                            color: Colors.black,
                            text_align: TextAlign.left,
                            fontWeight: null,
                          ),
                        ),
                        Radio(
                            value: "ใส่ถ่วย",
                            groupValue: foodtype[index],
                            onChanged: (value) {
                              if (!(snapshot.data!.docs[index]['qty'] == 0 ||
                                  snapshot.data!.docs[index]['qty'] == null)) {
                                foodtype[index] = value!;
                                setState(() {});
                              }

                              print(value); //selected value
                            }),
                        Radio(
                            value: "ราดข้าว",
                            groupValue: foodtype[index],
                            onChanged: (value) {
                              if (!(snapshot.data!.docs[index]['qty'] == 0 ||
                                  snapshot.data!.docs[index]['qty'] == null)) {
                                foodtype[index] = value!;
                                setState(() {});
                              }
                              print(value); //selected value
                            }),
                        Container(
                            height: 100,
                            width: 75,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Opacity(
                                  opacity: snapshot.data!.docs[index]['qty'] ==
                                              0 ||
                                          snapshot.data!.docs[index]['qty'] ==
                                              null
                                      ? 0.5
                                      : 1,
                                  child: Container(
                                    height: 70,
                                    child: Image.network(
                                      snapshot.data!.docs[index]['foodimg'],
                                    ),
                                  ),
                                ),
                                Text("จำนวน : " +
                                    snapshot.data!.docs[index]['qty']
                                        .toString()),
                              ],
                            ))
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget buildCartButton() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.04),
      width: width * 0.85,
      height: height * 0.06,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black87,
            backgroundColor: Colors.green,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          onPressed: () async {
            setState(() {});
            print(foodtype);
            cartpressed();
          },
          child: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          )),
    );
  }

  Future<void> cartpressed() async {
    List foodid = [];
    List foodlist = [];
    List foodtyping = [];
    List foodprice = [];
    try {
      await FirebaseFirestore.instance
          .collection("Food")
          .where("restaurantid", isEqualTo: widget.restaurantid)
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          if (foodtype[i] != "") {
            foodid.add(value.docs[i].reference.path.split("/").last);
            foodlist.add(value.docs[i]['name']);
            foodtyping.add(foodtype[i]);
            foodprice.add(double.parse(value.docs[i]['price']));
          }
        }
        print(foodid);
        print(foodlist);
        print(foodtyping);
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return ConfrimOrderScreen(
            restaurantid: widget.restaurantid,
            foodid: foodid,
            foodlist: foodlist,
            foodtype: foodtyping,
            foodprice: foodprice,
            mode: 'food',
          );
        }));
      });
    } catch (e) {
      print(e);
    }
  }
}
