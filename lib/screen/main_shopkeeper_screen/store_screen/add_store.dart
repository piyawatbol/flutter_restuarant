// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_bs/widget/auto_size_text.dart';

class AddStoreScreen extends StatefulWidget {
  @override
  State<AddStoreScreen> createState() => _AddStoreScreenState();
}

class _AddStoreScreenState extends State<AddStoreScreen> {
  final auth = FirebaseAuth.instance;
  TextEditingController store_name = TextEditingController();
  TextEditingController restaurantid = TextEditingController();
  File? _image;
  String? type = null;
  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<void> imagepicker() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  add_store() async {
    Reference ref =
        FirebaseStorage.instance.ref().child(getRandomString(10) + ".png");
    try {
      await ref.putFile(File(_image!.path));
      ref.getDownloadURL().then((v) async {
        print(v);
        try {
          FirebaseFirestore.instance.collection("Restaurant").doc().set({
            "store_img": v,
            "name": store_name.text,
            "restaurantid": restaurantid.text,
            "type": type.toString(),
            "uid": auth.currentUser!.uid
          }).then((value) {
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Color(0xffC4CFD4),
          title: Text(
            "เพิ่มร้าน",
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildImage(),
                buildBox("หมายเลขร้าน", restaurantid),
                buildBox("ชื่อร้าน", store_name),
                buildDropBox("ประเภทร้าน"),
                buildAddButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        imagepicker();
      },
      child: _image == null
          ? Container(
              margin: EdgeInsets.symmetric(
                  vertical: height * 0.03, horizontal: width * 0.07),
              width: width,
              height: height * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color(0xff8A9EA8),
                ),
              ),
              child: Icon(Icons.add),
            )
          : Container(
              margin: EdgeInsets.symmetric(
                  vertical: height * 0.012, horizontal: width * 0.07),
              width: width,
              height: height * 0.2,
              child: Image.file(_image!, fit: BoxFit.cover),
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
                  return ('กรุณากรอกข้อมูล');
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

  Widget buildDropBox(String? text) {
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
          Container(
            width: width,
            padding: EdgeInsets.symmetric(
                vertical: height * 0.01, horizontal: width * 0.07),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[600]!),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButton<String>(
                underline: SizedBox(),
                items: [
                  DropdownMenuItem<String>(
                    value: "ร้านข้าว",
                    child: Text(
                      "ร้านข้าว",
                      style: GoogleFonts.mitr(
                          textStyle: const TextStyle(
                              color: Colors.black, fontSize: 14)),
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: "ร้านน้ำ",
                    child: Text(
                      "ร้านน้ำ",
                      style: GoogleFonts.mitr(
                          textStyle: const TextStyle(
                              color: Colors.black, fontSize: 14)),
                    ),
                  ),
                ],
                hint: Text("$text",
                    style: GoogleFonts.mitr(
                        textStyle:
                            const TextStyle(color: Colors.grey, fontSize: 14))),
                value: type,
                onChanged: (v) {
                  type = v!;
                  setState(() {});
                }),
          )
        ],
      ),
    );
  }

  Widget buildAddButton() {
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
          add_store();
        },
        child: AutoText(
          color: Colors.white,
          fontSize: 16,
          fontWeight: null,
          text: 'เพิ่มร้าน',
          text_align: TextAlign.center,
          width: width * 0.2,
        ),
      ),
    );
  }
}
