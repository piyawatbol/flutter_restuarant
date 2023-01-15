import 'package:flutter/material.dart';

class Q001 extends StatefulWidget {
  const Q001({super.key});

  @override
  State<Q001> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Q001> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("คิว")),
        body: SingleChildScrollView(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "   เหลือคิวอีก ",
                  style: TextStyle(fontSize: 40),
                ),
                Text(
                  " \n 4 ",
                  style: TextStyle(fontSize: 60),
                )
              ],
            )
          ],
        )));
  }
}
