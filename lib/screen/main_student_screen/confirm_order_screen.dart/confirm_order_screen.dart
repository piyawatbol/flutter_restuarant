import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_bs/screen/main_student_screen/confirm_order_screen.dart/confirm_pay_screen.dart';
import 'package:my_bs/widget/auto_size_text.dart';

class ConfrimOrderScreen extends StatefulWidget {
  final restaurantid;
  final List foodid;
  final List foodlist;
  final List foodprice;
  final List foodtype;
  final String mode;
  ConfrimOrderScreen(
      {Key? key,
      required this.foodid,
      required this.foodlist,
      required this.foodtype,
      required this.foodprice,
      required this.restaurantid,
      required this.mode})
      : super(key: key);

  @override
  State<ConfrimOrderScreen> createState() => _ConfrimOrderScreenState();
}

class _ConfrimOrderScreenState extends State<ConfrimOrderScreen> {
  TextEditingController detail = TextEditingController();
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
            "ยืนยันออเดอร์",
            style: GoogleFonts.mitr(
              textStyle: TextStyle(
                color: Color(0xff576B75),
                fontSize: 20,
              ),
            ),
          ),
        ),
        body: Container(
          width: width,
          height: height,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.07,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/food2.png"),
                      ],
                    ),
                  ),
                  buildCount(),
                  Container(
                    height: height * 0.2,
                    child: ListView.builder(
                      itemCount: widget.foodid.length,
                      itemBuilder: (context, index) {
                        return buildRowText(widget.foodlist[index],
                            widget.foodprice[index].toString());
                      },
                    ),
                  ),
                  buildResult(),
                  buildDetail(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [buildConfirmButton(), buildCancelButton()],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCount() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoText(
            width: width * 0.5,
            text: "รายการ",
            fontSize: 24,
            color: Colors.black,
            text_align: TextAlign.left,
            fontWeight: null,
          ),
          AutoText(
            width: width * 0.3,
            text: "จำนวน  ${widget.foodid.length}",
            fontSize: 24,
            color: Colors.black,
            text_align: TextAlign.right,
            fontWeight: null,
          ),
        ],
      ),
    );
  }

  Widget buildRowText(String? text, String? price) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.002),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoText(
            width: width * 0.5,
            text: "$text",
            fontSize: 16,
            color: Colors.black,
            text_align: TextAlign.left,
            fontWeight: null,
          ),
          AutoText(
            width: width * 0.1,
            text: widget.mode == "water" ? "$price" : "",
            fontSize: 16,
            color: Colors.black,
            text_align: TextAlign.right,
            fontWeight: null,
          ),
        ],
      ),
    );
  }

  Widget buildResult() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoText(
            width: width * 0.24,
            text: "ยอดรวม",
            fontSize: 24,
            color: Colors.black,
            text_align: TextAlign.left,
            fontWeight: null,
          ),
          AutoText(
            width: width * 0.2,
            text: widget.mode == "water"
                ? "${(widget.foodprice.reduce((value, element) => value + element)).toString()} บาท"
                : widget.foodid.length > 2
                    ? "35.0 บาท"
                    : "30.0 บาท",
            fontSize: 24,
            color: Colors.black,
            text_align: TextAlign.right,
            fontWeight: null,
          ),
        ],
      ),
    );
  }

  Widget buildDetail() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoText(
          width: width * 0.23,
          text: "หมายเหตุ",
          fontSize: 22,
          color: Colors.black,
          text_align: TextAlign.left,
          fontWeight: null,
        ),
        SizedBox(height: height * 0.01),
        TextField(
          maxLines: 4,
          controller: detail,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintStyle: GoogleFonts.mitr(
              textStyle: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
                horizontal: width * 0.06, vertical: height * 0.015),
          ),
        )
      ],
    );
  }

  Widget buildConfirmButton() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.04),
      width: width * 0.3,
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
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return ConfirmPayScreen(
              restaurantid: widget.restaurantid,
              foodid: widget.foodid,
              foodlist: widget.foodlist,
              foodprice: widget.foodprice,
              foodtype: widget.foodtype,
              fooddetail: detail.text,
              mode: widget.mode,
            );
          }));
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

  Widget buildCancelButton() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.04),
      width: width * 0.3,
      height: height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black87,
          backgroundColor: Colors.red,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        onPressed: () async {
          Navigator.pop(context);
        },
        child: AutoText(
          color: Colors.white,
          fontSize: 16,
          fontWeight: null,
          text: 'ยกเลิก',
          text_align: TextAlign.center,
          width: width * 0.2,
        ),
      ),
    );
  }
}
