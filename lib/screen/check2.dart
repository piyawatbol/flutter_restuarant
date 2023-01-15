import 'package:flutter/material.dart';
import 'package:my_bs/screen/Queue_Food.dart';
import 'package:my_bs/screen/main_student_screen/choose_store_screen/choose_store_food_screen.dart';

class Check2Screen extends StatefulWidget {
  const Check2Screen({super.key});

  @override
  State<Check2Screen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<Check2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("ตรวจรายการอาหาร")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  "assets/images/dog.png",
                  height: 250,
                  width: 300,
                ),
                Text(
                  "ร้านน้ำ                 จำนวน",
                  style: TextStyle(fontSize: 25),
                ),
                Text("ชาเขียว                   " "5",
                    style: TextStyle(fontSize: 25)),
                Text("รวมยอด                  " "100",
                    style: TextStyle(fontSize: 25)),
                Text("หมายเหตุ", style: TextStyle(fontSize: 35)),
                SizedBox(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Q001();
                      }));
                    },
                    icon: Icon(Icons.shopping_cart),
                    label: Text((" ยืนยัน"), style: TextStyle(fontSize: 15)),
                  ),
                ),
                SizedBox(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ChooseStoreFoodScreen();
                      }));
                    },
                    icon: Icon(Icons.cancel),
                    label: Text(("ยกเลิก "), style: TextStyle(fontSize: 15)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
