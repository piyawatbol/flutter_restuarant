import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_bs/screen/main_student_screen/confirm_order_screen.dart/get_food_screen.dart';

class QueueScreen extends StatefulWidget {
  final queue;
  final restaurantid;
  QueueScreen({Key? key, this.queue, this.restaurantid}) : super(key: key);

  @override
  State<QueueScreen> createState() => _QueueScreenState();
}

class _QueueScreenState extends State<QueueScreen> {
  final auth = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.1),
                child: Text(
                  "คิวของคุณคือ",
                  style: GoogleFonts.mitr(
                    textStyle: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    await FirebaseFirestore.instance
                        .collection("Order")
                        .where("restaurantid", isEqualTo: widget.restaurantid)
                        .where("queue", isEqualTo: widget.queue)
                        .where("uid", isEqualTo: auth!.uid)
                        .where("orderstatus", isEqualTo: "0")
                        .get()
                        .then((value) {
                      print(value.docs.first.reference.path.split("/").last);
                      FirebaseFirestore.instance
                          .collection("Order")
                          .doc(value.docs.first.reference.path.split("/").last)
                          .update({"orderstatus": "1"}).then((value) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return GetFoodScreen();
                        }));
                      });
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text(
                  widget.queue.toString(),
                  style: GoogleFonts.mitr(
                    textStyle: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                      fontSize: 120,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
