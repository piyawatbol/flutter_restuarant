import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_bs/widget/auto_size_text.dart';

class addmoney extends StatefulWidget {
  const addmoney({super.key});
  @override
  State<addmoney> createState() => _addmoneyState();
}

class _addmoneyState extends State<addmoney> {
  TextEditingController student = TextEditingController();
  TextEditingController money = TextEditingController();

  ButtonStyle elstyle = ElevatedButton.styleFrom(backgroundColor: Colors.white);
  TextStyle textstyle = GoogleFonts.mitr(
    textStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
  );
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
            "เพิ่มเงินให้นักเรียน",
            style: GoogleFonts.mitr(
              textStyle: TextStyle(
                color: Color(0xff576B75),
                fontSize: 20,
              ),
            ),
          ),
        ),
        body: Container(
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height * 0.04),
                Form(
                    child: Container(
                  child: Column(
                    children: [
                      buildBox("รหัสนักเรียน", student, TextInputType.name),
                      buildBox("จำนวนเงิน", money, TextInputType.number),
                    ],
                  ),
                )),
                buildMoney(),
                buildAddButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMoney() {
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(30),
      height: height * 0.4,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 20, crossAxisSpacing: 20),
        children: [
          ElevatedButton(
              style: elstyle,
              onPressed: () {
                if (money.text == "") {
                  money.text = 20.toString();
                } else {
                  money.text = (int.parse(money.text) + 20).toString();
                }
              },
              child: Text(
                "20",
                style: textstyle,
              )),
          ElevatedButton(
              style: elstyle,
              onPressed: () {
                if (money.text == "") {
                  money.text = 50.toString();
                } else {
                  money.text = (int.parse(money.text) + 50).toString();
                }
              },
              child: Text(
                "50",
                style: textstyle,
              )),
          ElevatedButton(
              style: elstyle,
              onPressed: () {
                if (money.text == "") {
                  money.text = 100.toString();
                } else {
                  money.text = (int.parse(money.text) + 100).toString();
                }
              },
              child: Text(
                "100",
                style: textstyle,
              )),
          ElevatedButton(
              style: elstyle,
              onPressed: () {
                if (money.text == "") {
                  money.text = 300.toString();
                } else {
                  money.text = (int.parse(money.text) + 300).toString();
                }
              },
              child: Text(
                "300",
                style: textstyle,
              )),
          ElevatedButton(
              style: elstyle,
              onPressed: () {
                if (money.text == "") {
                  money.text = 500.toString();
                } else {
                  money.text = (int.parse(money.text) + 500).toString();
                }
              },
              child: Text(
                "500",
                style: textstyle,
              )),
        ],
      ),
    );
  }

  Widget buildAddButton() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.85,
      height: height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black87,
          backgroundColor: Colors.green,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        onPressed: () {
          setState(() {});
          try {
            FirebaseFirestore.instance
                .collection("Users")
                .where("id", isEqualTo: student.text)
                .get()
                .then((value) {
              print(value.docs);
              if (value.docs.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("ไม่พบไอดีของนักศึกษา"),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("ตกลง"))
                      ],
                    );
                  },
                );
                throw Exception("ไม่พบไอดีของนักศึกษา");
              } else {
                print(value.docs.first.reference.path.split("/").last);
                print(value.docs.first['wallet']);
                double newmoney = double.parse(value.docs.first['wallet']) +
                    double.parse(money.text);
                try {
                  FirebaseFirestore.instance
                      .collection("Users")
                      .doc(value.docs.first.reference.path.split("/").last)
                      .update({"wallet": newmoney.toString()}).then(
                          (value) => Navigator.of(context).pop());
                } on Exception catch (e) {
                  print("Error : " + e.toString());
                } catch (e) {
                  print(e);
                }
              }
            });
          } catch (e) {
            print(e);
          }
        },
        child: AutoText(
          color: Colors.white,
          fontSize: 16,
          fontWeight: null,
          text: 'ยืนยัน',
          text_align: TextAlign.center,
          width: width * 0.2,
        ),
      ),
    );
  }

  Widget buildBox(
      String? text, TextEditingController controller, TextInputType type) {
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
              keyboardType: type,
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
