import 'package:flutter/material.dart';
import 'package:my_bs/screen/S_water.dart';

class Choose_food extends StatefulWidget {
  const Choose_food({super.key});

  @override
  State<Choose_food> createState() => _Choose_foodState();
}

class _Choose_foodState extends State<Choose_food> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("เลือกร้านอาหาร")),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Waater_S();
                      }));
                    },
                    iconSize: 200.00,
                    icon: Image.asset(
                      "assets/images/button.png",
                    )),
                IconButton(
                    onPressed: () {
                    
                    },
                    iconSize: 200.00,
                    icon: Image.asset(
                      "assets/images/button.png",
                    )),
                IconButton(
                    onPressed: () {},
                    iconSize: 200.00,
                    icon: Image.asset(
                      "assets/images/button.png",
                    ))
              ]),
        ));
  }
}
