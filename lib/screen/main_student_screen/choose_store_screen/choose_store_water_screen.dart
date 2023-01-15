import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_bs/screen/main_student_screen/choose_store_screen/choose_water_screen.dart';
import 'package:my_bs/widget/auto_size_text.dart';

class ChooseStoreWaterScreen extends StatefulWidget {
  const ChooseStoreWaterScreen({super.key});

  @override
  State<ChooseStoreWaterScreen> createState() => _ChooseStoreWaterScreenState();
}

class _ChooseStoreWaterScreenState extends State<ChooseStoreWaterScreen> {
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
          "ร้านน้ำ",
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
            buildStore(),
          ],
        ),
      ),
    );
  }

  Widget buildStore() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Restaurant")
            .where("type", isEqualTo: "ร้านน้ำ")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error" + snapshot.error.toString());
          } else if (snapshot.hasData) {
            return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return ChooseWaterScreen(
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
                              Image.network(
                                  snapshot.data!.docs[index]['store_img'])
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
}
