import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_bs/screen/main_student_screen/profile_student_screen.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 2, 3, 0),
          child: Form(
            key: formkey,
            child: Column(children: [
              Text(
                "ID Student",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                controller: username,
              ),
              Text("Password", style: TextStyle(fontSize: 20)),
              TextFormField(
                controller: password,
                obscureText: true,
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                child: FutureBuilder(
                  future: firebase,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error : " + snapshot.error.toString());
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return ElevatedButton.icon(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: username.text,
                                        password: password.text)
                                    .then((value) {
                                  formkey.currentState!.reset();
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ProfileStudentScreen();
                                  }));
                                });
                              } on FirebaseAuthException catch (e) {
                                print(e.message);
                              }
                            }
                          },
                          icon: Icon(Icons.login),
                          label: Text("LOGIN", style: TextStyle(fontSize: 22)));
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
