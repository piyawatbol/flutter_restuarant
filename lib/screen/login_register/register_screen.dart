import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_bs/screen/main_shopkeeper_screen/profile_shopkeeper_screen.dart';
import 'package:my_bs/screen/main_teacher_screen/Profileteacher.dart';
import 'package:my_bs/screen/main_student_screen/profile_student_screen.dart';
import 'package:my_bs/widget/auto_size_text.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController student_id = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController _class = TextEditingController();
  String? type = null;
  File? _image;

  Future<void> imagepicker() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
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
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Container(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.02,
                    ),
                    child: AutoText(
                      width: width * 0.56,
                      text: "สมัครสมาชิก",
                      fontSize: 50,
                      color: Colors.black,
                      text_align: TextAlign.center,
                      fontWeight: null,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      imagepicker();
                    },
                    child: _image == null
                        ? CircleAvatar(
                            minRadius: 50,
                            maxRadius: 50,
                            backgroundImage:
                                AssetImage("assets/images/profile.png"),
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.transparent,
                            minRadius: 50,
                            maxRadius: 50,
                            backgroundImage: FileImage(File(_image!.path)),
                          ),
                  ),
                  buildBox("รหัสนักเรียน", student_id),
                  buildBox("อีเมล", email),
                  buildBox("ชื่อ", name),
                  buildBox("นามสกุล", lastname),
                  buildBox("ชื่อผู้ใช้", username),
                  buildBox("รหัสผ่าน", password),
                  buildBox("ระดับชั้น", _class),
                  buildDropBox("ประเภท"),
                  buildRegisterButton(
                      student_id.text.trim(),
                      email.text.trim(),
                      name.text.trim(),
                      lastname.text.trim(),
                      username.text.trim(),
                      password.text.trim())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBackbutton() {
    double height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.02,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  Widget buildBox(String? text, TextEditingController controller) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.01, horizontal: width * 0.07),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.18,
            child: AutoSizeText(
              "$text",
              minFontSize: 1,
              maxLines: 1,
              style: GoogleFonts.mitr(
                  textStyle:
                      const TextStyle(color: Colors.black, fontSize: 14)),
            ),
          ),
          TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return ('กรุณากรอกชื่อผู้ใช้');
                }
                return null;
              },
              controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "$text",
                hintStyle: GoogleFonts.mitr(
                  textStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: width * 0.06, vertical: height * 0.015),
              )),
        ],
      ),
    );
  }

  Widget buildDropBox(String? text) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.01, horizontal: width * 0.07),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.18,
            child: AutoSizeText(
              "$text",
              minFontSize: 1,
              maxLines: 1,
              style: GoogleFonts.mitr(
                  textStyle:
                      const TextStyle(color: Colors.black, fontSize: 14)),
            ),
          ),
          Container(
            width: width,
            padding: EdgeInsets.symmetric(
                vertical: height * 0.01, horizontal: width * 0.07),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[600]!),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButton<String>(
                underline: SizedBox(),
                items: [
                  DropdownMenuItem<String>(
                    value: "Student",
                    child: Text(
                      "นักเรียน",
                      style: GoogleFonts.mitr(
                          textStyle: const TextStyle(
                              color: Colors.black, fontSize: 14)),
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: "Teacher",
                    child: Text(
                      "อาจารย์/ครู",
                      style: GoogleFonts.mitr(
                          textStyle: const TextStyle(
                              color: Colors.black, fontSize: 14)),
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: "Shopkeeper",
                    child: Text(
                      "เจ้าของร้าน",
                      style: GoogleFonts.mitr(
                          textStyle: const TextStyle(
                              color: Colors.black, fontSize: 14)),
                    ),
                  ),
                ],
                hint: Text("$text",
                    style: GoogleFonts.mitr(
                        textStyle:
                            const TextStyle(color: Colors.grey, fontSize: 14))),
                value: type,
                onChanged: (v) {
                  type = v!;
                  setState(() {});
                }),
          )
        ],
      ),
    );
  }

  Widget buildRegisterButton(
      student_id, email, name, lastname, username, password) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.04),
      width: width * 0.85,
      height: height * 0.06,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black87,
          backgroundColor: Colors.green,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        onPressed: () async {
          setState(() {});
          if (email.isEmpty) {
            print("Email is Empty");
          } else {
            if (password.isEmpty) {
              print("Password is Empty");
            } else if (_image == null) {
              print("Image is Empty");
            } else {
              try {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: email, password: password)
                    .then((value) async {
                  Reference ref = FirebaseStorage.instance
                      .ref()
                      .child(getRandomString(10) + ".png");
                  var uid = FirebaseAuth.instance.currentUser!.uid;
                  await ref.putFile(File(_image!.path));
                  ref.getDownloadURL().then((v) async {
                    await FirebaseFirestore.instance
                        .collection("Users")
                        .doc(uid)
                        .set({
                      'uid': uid,
                      'email': email,
                      'name': name,
                      'lname': lastname,
                      'id': student_id,
                      'type': type,
                      'wallet': "0",
                      'username': username,
                      'userimg': v,
                      'class': _class.text,
                    }).then((value) {
                      if (type == "Student") {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return ProfileStudentScreen();
                        }));
                      } else if (type == "Teacher") {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const Profile_Teacher();
                        }));
                      } else if (type == "Shopkeeper") {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const ProfileShopkeeperScreen();
                        }));
                      } else {}
                    });
                  });
                });
              } on FirebaseAuthException catch (e) {
                print(e.message);
              } catch (e) {
                print(e);
              }
            }
          }
        },
        child: AutoText(
          color: Colors.white,
          fontSize: 16,
          fontWeight: null,
          text: 'สมัครสมาชิก',
          text_align: TextAlign.center,
          width: width * 0.2,
        ),
      ),
    );
  }
}
