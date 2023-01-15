import 'package:flutter/material.dart';
import 'package:my_bs/screen/login_register/login_screen.dart';
import 'package:my_bs/widget/auto_size_text.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png"),
            buildSingInButton()
          ],
        ),
      ),
    );
  }

  Widget buildSingInButton() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.5,
      height: height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black87,
          backgroundColor: Colors.green,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return LoginScreen();
          }));
        },
        child: AutoText(
          color: Colors.white,
          fontSize: 16,
          fontWeight: null,
          text: 'เข้าสู่ระบบ',
          text_align: TextAlign.center,
          width: width * 0.2,
        ),
      ),
    );
  }
}
