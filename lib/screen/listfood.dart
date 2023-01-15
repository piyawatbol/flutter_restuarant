import 'package:flutter/material.dart';
import 'package:my_bs/screen/editSfood.dart';

class listfood extends StatefulWidget {
  const listfood({super.key});

  @override
  State<listfood> createState() => _listfoodState();
}

class _listfoodState extends State<listfood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ปรับแต่งรายการอาหาร")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
          child: Wrap(
            spacing: 30,
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return editfoodshop();
                    }));
                  },
                  iconSize: 100.00,
                  icon: Image.asset(
                    "assets/images/edit.png",
                  )),
              Text(
                  "                                                                 "),
              Text("\n\tน้ำแขียว\t\t\t\t"),
              SizedBox(
                width: 100,
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
              ),
              Image.asset(
                "assets/images/logo.png",
                height: 80,
                width: 120,
              ),
              Text("\n\tนมเย็น \t\t\t\t\t"),
              SizedBox(
                width: 100,
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
              ),
              Image.asset(
                "assets/images/logo.png",
                height: 80,
                width: 120,
              ),
              Text("\n\tชาเย็น \t\t\t\t\t"),
              SizedBox(
                width: 100,
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
              ),
              Image.asset(
                "assets/images/logo.png",
                height: 80,
                width: 120,
              ),
              Text("\n\tชาเขียว \t\t\t\t"),
              SizedBox(
                width: 100,
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
              ),
              Image.asset(
                "assets/images/logo.png",
                height: 80,
                width: 120,
              ),
              Text("\n\tไมโล    \t\t\t\t\t"),
              SizedBox(
                width: 100,
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
              ),
              Image.asset(
                "assets/images/logo.png",
                height: 80,
                width: 120,
              ),
              Text("\n\tชาดำ   \t\t\t\t\t"),
              SizedBox(
                width: 100,
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
              ),
              Image.asset(
                "assets/images/logo.png",
                height: 80,
                width: 120,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
