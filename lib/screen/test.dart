import 'package:flutter/material.dart';

class test001 extends StatelessWidget {
  const test001({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Center(
            child: GestureDetector(
              child: const Text("uplond"),
            ),
          )
        ],
      )),
    );
  }
}
