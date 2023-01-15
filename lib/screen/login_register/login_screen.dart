// ignore_for_file: unused_local_variable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_bs/screen/main_shopkeeper_screen/profile_shopkeeper_screen.dart';
import 'package:my_bs/screen/main_teacher_screen/Profileteacher.dart';

import 'package:my_bs/screen/login_register/register_screen.dart';
import 'package:my_bs/screen/main_student_screen/profile_student_screen.dart';
import 'package:my_bs/widget/auto_size_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool pass = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.06),
                    child: AutoText(
                        width: width * 0.56,
                        text: "เข้าสู่ระบบ",
                        fontSize: 50,
                        color: Colors.black,
                        text_align: TextAlign.center,
                        fontWeight: null),
                  ),
                  SizedBox(height: height * 0.02),
                  Form(
                    key: formkey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildUserBox(),
                            SizedBox(height: height * 0.04),
                            buildPassowordBox(),
                            buildForget(),
                            buildSingInButton(),
                            buildRegister()
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUserBox() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width * 0.18,
          child: AutoSizeText(
            "ชื่อผูัใช้",
            minFontSize: 1,
            maxLines: 1,
            style: GoogleFonts.mitr(
                textStyle: TextStyle(color: Colors.black, fontSize: 14)),
          ),
        ),
        TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return ('กรุณากรอกชื่อผู้ใช้');
              }
              return null;
            },
            controller: username,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "ชื่อผู้ใช้",
              hintStyle: GoogleFonts.mitr(
                textStyle: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: width * 0.06, vertical: height * 0.015),
            )),
      ],
    );
  }

  Widget buildPassowordBox() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width * 0.18,
          child: AutoSizeText(
            "รหัสผ่าน",
            minFontSize: 1,
            maxLines: 1,
            style: GoogleFonts.mitr(
                textStyle: TextStyle(color: Colors.black, fontSize: 14)),
          ),
        ),
        TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return ('กรุณากรอกรหัสผ่าน');
              }
              return null;
            },
            controller: password,
            obscureText: pass,
            decoration: InputDecoration(
              hintText: "รหัสผ่าน",
              suffixIcon: pass == true
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          pass = !pass;
                        });
                      },
                      icon: Icon(
                        Icons.visibility_off,
                        color: Colors.black,
                      ))
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          pass = !pass;
                        });
                      },
                      icon: Icon(
                        Icons.visibility,
                        color: Colors.black,
                      ),
                    ),
              hintStyle: GoogleFonts.mitr(
                textStyle: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: width * 0.06, vertical: height * 0.015),
            )),
      ],
    );
  }

  Widget buildForget() {
    return Row(
      children: [
        Text(
          "ลืมรหัสผ่าน",
          style: GoogleFonts.mitr(
            textStyle: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSingInButton() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.04),
      width: double.infinity,
      height: height * 0.06,
      child: FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error : " + snapshot.error.toString());
          } else if (snapshot.connectionState == ConnectionState.done) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black87,
                backgroundColor: Colors.green,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              onPressed: () async {
                if (formkey.currentState!.validate()) {
                  try {
                    await FirebaseFirestore.instance
                        .collection("Users")
                        .where("username", isEqualTo: username.text)
                        .get()
                        .then((value) async {
                      // print(value.docs[0]['email']);
                      try {
                        await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: value.docs[0]['email'],
                                password: password.text)
                            .then((v) {
                          formkey.currentState!.reset();
                          print(value);
                          FirebaseAuth Auth = FirebaseAuth.instance;
                          if (value.docs[0]['type'] == "Student") {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return ProfileStudentScreen();
                            }));
                          } else if (value.docs[0]['type'] == "Teacher") {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return Profile_Teacher();
                            }));
                          } else if (value.docs[0]['type'] == "Shopkeeper") {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return ProfileShopkeeperScreen();
                            }));
                          } else {}
                        });
                      } on FirebaseAuthException catch (e) {
                        print(e.message);
                        if (e.message ==
                            'Ignoring header X-Firebase-Locale because its value was null') {
                          print("hello");
                        }
                        if (e.message ==
                            "The password is invalid or the user does not have a password.") {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("รหัสผ่านหรือชื่อผู้ใช้ไม่ถูกต้อง"),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("ตกลง"))
                                ],
                              );
                            },
                          );
                        }
                      }
                    });
                  } catch (e) {
                    print(e);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("ไม่พบชื่อผู้ใช้นี้"),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("ตกลง"))
                          ],
                        );
                      },
                    );
                  }
                }
              },
              child: AutoText(
                color: Colors.white,
                fontSize: 16,
                fontWeight: null,
                text: 'เข้าสู่ระบบ',
                text_align: TextAlign.center,
                width: width * 0.2,
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget buildRegister() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return RegisterScreen();
            }));
          },
          child: Text(
            "สมัครสมาชิก",
            style: GoogleFonts.mitr(
              textStyle: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        )
      ],
    );
  }
}
