import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("about us"),
      ),
      body: Column(
        children: [
          Text(
            Get.arguments.toString(),
          ),
        ],
      ),
    );
  }
}
