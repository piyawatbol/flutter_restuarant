import 'package:flutter/material.dart';

class editfoodshop extends StatelessWidget {
  const editfoodshop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("แก้ไขรายการอาหาร")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(),
              IconButton(
                  onPressed: () {},
                  iconSize: 50,
                  icon: Image.asset("assets/images/ADD.png")),
              IconButton(
                  onPressed: () {},
                  iconSize: 50,
                  icon: Image.asset("assets/images/DEL.png"))
            ],
          ),
        ),
      ),
    );
  }
}
