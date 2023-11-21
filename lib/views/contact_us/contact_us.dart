import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact"),
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
