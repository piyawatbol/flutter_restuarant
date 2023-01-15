import 'package:flutter/material.dart';
import 'package:my_bs/screen/main_student_screen/profile_student_screen.dart';
import 'package:my_bs/widget/auto_size_text.dart';

class GetFoodScreen extends StatefulWidget {
  GetFoodScreen({Key? key}) : super(key: key);

  @override
  State<GetFoodScreen> createState() => _GetFoodScreenState();
}

class _GetFoodScreenState extends State<GetFoodScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/food2.png"),
                ],
              ),
            ),
            AutoText(
              color: Colors.black,
              fontSize: 18,
              fontWeight: null,
              text: 'อาหารของคุณได้รับแล้ว',
              text_align: TextAlign.left,
              width: width * 0.5,
            ),
            SizedBox(height: height * 0.1),
            buildConfirmButton()
          ],
        ),
      ),
    );
  }

  Widget buildConfirmButton() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.04),
      width: width * 0.35,
      height: height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black87,
          backgroundColor: Colors.green,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        onPressed: () async {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return ProfileStudentScreen();
          }), (route) => false);
        },
        child: AutoText(
          color: Colors.white,
          fontSize: 16,
          fontWeight: null,
          text: 'ยืนยัน',
          text_align: TextAlign.center,
          width: width * 0.3,
        ),
      ),
    );
  }
}
