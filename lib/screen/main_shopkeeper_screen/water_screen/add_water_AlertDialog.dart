import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddWaterAlertDialog extends StatefulWidget {
  final restaurantid;
  const AddWaterAlertDialog({super.key, this.restaurantid});

  @override
  State<AddWaterAlertDialog> createState() => _AddWaterAlertDialogState();
}

class _AddWaterAlertDialogState extends State<AddWaterAlertDialog> {
  final formkeyadd = GlobalKey<FormState>();
  TextEditingController Foodname = TextEditingController();
  TextEditingController Foodprice = TextEditingController();
  TextEditingController Foodqty = TextEditingController();
  File? imgadd = null;
  Future<void> imagepickeradd() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imgadd = File(image!.path);
    });
  }

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  void addfood() async {
    Reference ref =
        FirebaseStorage.instance.ref().child(getRandomString(10) + ".png");
    try {
      await ref.putFile(File(imgadd!.path));
      ref.getDownloadURL().then((v) async {
        print(v);
        try {
          FirebaseFirestore.instance.collection("Food").doc().set({
            "foodimg": v,
            "name": Foodname.text,
            "restaurantid": widget.restaurantid,
            "price": Foodprice.text,
            "qty": int.parse(Foodqty.text)
          }).then((value) {
            Navigator.pop(context);
            Navigator.pop(context);
          });
        } catch (e) {
          print(e);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      content: Container(
        padding: EdgeInsets.only(top: height * 0.025),
        width: width * 0.8,
        height: height * 0.6,
        child: Form(
            key: formkeyadd,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: height * 0.012),
                    width: width * 0.5,
                    height: height * 0.15,
                    color: Color(0xffdedede),
                    child: GestureDetector(
                        onTap: () {
                          imagepickeradd();
                        },
                        child: imgadd == null
                            ? Icon(
                                Icons.add_a_photo,
                                size: 50,
                              )
                            : Image.file(
                                File(imgadd!.path),
                                fit: BoxFit.cover,
                              )),
                  ),
                  buildBox("ชื่อเครื่องดื่ม", Foodname),
                  buildBox("ราคา", Foodprice),
                  buildBox("จำนวน", Foodqty),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {});
                        if (formkeyadd.currentState!.validate()) {
                          if (imgadd != null) {
                            addfood();
                          }
                        }
                      },
                      child: Text(
                        "เพิ่ม",
                        style: GoogleFonts.mitr(
                          textStyle: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget buildBox(String? text, TextEditingController controller) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.01, horizontal: width * 0.07),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.18,
            child: AutoSizeText(
              "$text",
              minFontSize: 1,
              maxLines: 1,
              style: GoogleFonts.mitr(
                  textStyle:
                      const TextStyle(color: Colors.black, fontSize: 14)),
            ),
          ),
          TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return ('กรุณากรอก' + text!);
                }
                return null;
              },
              controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "$text",
                hintStyle: GoogleFonts.mitr(
                  textStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: width * 0.06, vertical: height * 0.015),
              )),
        ],
      ),
    );
  }
}
