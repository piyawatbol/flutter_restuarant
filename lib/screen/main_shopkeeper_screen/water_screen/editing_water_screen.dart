// ignore_for_file: unused_local_variable, unnecessary_null_comparison
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'add_water_AlertDialog.dart';

class EditingWaterScreen extends StatefulWidget {
  final restaurantid;
  const EditingWaterScreen({super.key, this.restaurantid});

  @override
  State<EditingWaterScreen> createState() => _EditingWaterScreenState();
}

class _EditingWaterScreenState extends State<EditingWaterScreen> {
  List<TextEditingController> controllername = [];
  List<TextEditingController> controllerprice = [];
  List<TextEditingController> controllerqty = [];
  @override
  void initState() {
    setcontroller();
    super.initState();
  }

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  Future<void> setcontroller() async {
    var foodlist = await FirebaseFirestore.instance
        .collection("Food")
        .where("restaurantid", isEqualTo: widget.restaurantid)
        .get();
    print(widget.restaurantid);
    print("it run");
    for (int i = 0; i < foodlist.docs.length; i++) {
      print(foodlist.docs[i]['name']);
      controllername.add(TextEditingController(text: foodlist.docs[i]['name']));
      controllerprice
          .add(TextEditingController(text: foodlist.docs[i]['price']));
      controllerqty
          .add(TextEditingController(text: foodlist.docs[i]['qty'].toString()));
    }
  }

  Future<void> imagepicker(imgname, food) async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 512, maxWidth: 512);
    Reference ref = FirebaseStorage.instance.ref().child(imgname);
    try {
      await ref.putFile(File(image!.path));
      ref.getDownloadURL().then((v) async {
        print(v);
        try {
          await FirebaseFirestore.instance
              .collection("Food")
              .doc(food)
              .update({'foodimg': v});
        } catch (e) {
          print(e);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  editfoodname(docid, name, price) {
    FirebaseFirestore.instance
        .collection("Food")
        .doc(docid)
        .update({'name': name, "price": price});
  }

  editfoodqty(docid, qty) {
    FirebaseFirestore.instance
        .collection("Food")
        .doc(docid)
        .update({'qty': qty});
  }

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
          "แก้ไขรายการน้ำดื่ม",
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
                  onPressed: () {},
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
      floatingActionButton: buildAddButton(),
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
              height: height * 0.68,
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
                          // AutoText(
                          //   width: width * 0.4,
                          //   text: snapshot.data!.docs[index]['name'],
                          //   fontSize: 18,
                          //   color: Colors.black,
                          //   text_align: TextAlign.left,
                          //   fontWeight: null,
                          // ),
                          Container(
                              width: width * 0.3,
                              child: TextField(
                                controller: controllername[index],
                              )),
                          Container(
                              width: width * 0.2,
                              child: TextField(
                                controller: controllerprice[index],
                              )),
                          Container(
                              width: width * 0.1,
                              child: IconButton(
                                onPressed: () {
                                  editfoodname(
                                      snapshot.data!.docs[index].reference.path
                                          .split("/")
                                          .last,
                                      controllername[index].text,
                                      controllerprice[index].text);
                                },
                                icon: Icon(Icons.edit),
                              )),
                          Container(
                            height: 120,
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 70,
                                  child: GestureDetector(
                                      onTap: () {
                                        imagepicker(
                                            getRandomString(10) + ".png",
                                            snapshot.data!.docs[index].reference
                                                .path
                                                .split("/")
                                                .last);
                                      },
                                      child: Image.network(snapshot
                                          .data!.docs[index]['foodimg'])),
                                ),
                                TextField(
                                    onChanged: (value) {
                                      print(value);
                                      if (value != null) {
                                        editfoodqty(
                                            snapshot.data!.docs[index].reference
                                                .path
                                                .split("/")
                                                .last,
                                            int.parse(value));
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    controller: controllerqty[index],
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixText: "จำนวน : ")),
                              ],
                            ),
                          )
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

  Widget buildAddButton() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return FloatingActionButton(
      foregroundColor: Colors.green,
      backgroundColor: Colors.green,
      // margin: EdgeInsets.symmetric(vertical: height * 0.04),
      // width: width,
      // height: height * 0.06,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AddWaterAlertDialog(
              restaurantid: widget.restaurantid,
            );
          },
        );
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
