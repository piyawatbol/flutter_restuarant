import 'package:flutter/material.dart';
import 'package:my_bs/screen/check_money.dart';

class Waater_S extends StatefulWidget {
  const Waater_S({super.key});

  @override
  State<Waater_S> createState() => _Waater_SState();
}

class _Waater_SState extends State<Waater_S> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ร้านขายน้ำ"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
          child: Wrap(
            spacing: 30,
            children: <Widget>[
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
              SizedBox(
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CheckScreen();
                      }));
                    },
                    icon: Icon(Icons.shopping_cart),
                    label: Text("")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
