import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_bs/widget/auto_size_text.dart';

import 'editing_water_screen.dart';

class EditWaterScreen extends StatefulWidget {
  final restaurantid;
  const EditWaterScreen({super.key, this.restaurantid});

  @override
  State<EditWaterScreen> createState() => _EditWaterScreenState();
}

class _EditWaterScreenState extends State<EditWaterScreen> {
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
          "รายการน้ำดื่ม",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return EditingWaterScreen(
                        restaurantid: widget.restaurantid,
                      );
                    }));
                  },
                  child: Text(
                    "แก้ไข",
                    style: GoogleFonts.mitr(
                      textStyle: TextStyle(
                        color: Color(0xff576B75),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                ),
              ),
              buildFood(),
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
            // return Container();
            return Container(
              height: height * 0.75,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 15, 20),
                    child: Container(
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
                          AutoText(
                            width: width * 0.1,
                            text: snapshot.data!.docs[index]['price'],
                            fontSize: 18,
                            color: Colors.black,
                            text_align: TextAlign.left,
                            fontWeight: null,
                          ),
                          Container(
                              height: 100,
                              width: 100,
                              child: Column(
                                children: [
                                  Container(
                                    height: 70,
                                    child: Image.network(
                                        snapshot.data!.docs[index]['foodimg']),
                                  ),
                                  Text("จำนวน : " +
                                      snapshot.data!.docs[index]['qty']
                                          .toString()),
                                ],
                              ))
                        ],
                      ),
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
}
