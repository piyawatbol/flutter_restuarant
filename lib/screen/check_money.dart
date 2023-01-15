import 'package:flutter/material.dart';
import 'package:my_bs/screen/check2.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({super.key});

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("ยืนยันการสั่งอาหาร")),
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
                Text("ชาเขียว               5", style: TextStyle(fontSize: 25)),
                Text("รวมยอด              100", style: TextStyle(fontSize: 25)),
                Text("หมายเหตุ", style: TextStyle(fontSize: 35)),
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Check2Screen();
                      }));
                    },
                    icon: Icon(Icons.shopping_cart),
                    label: Text((" "), style: TextStyle(fontSize: 40)),
                  ),
                ),
                SizedBox(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Check2Screen();
                      }));
                    },
                    icon: Icon(Icons.cancel),
                    label: Text((" "), style: TextStyle(fontSize: 40)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
