import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:pinterest_video_downloader/views/home/models/pinterest_model.dart';

class FetchData {
  PinterestModel dataModel = PinterestModel();
  fetchData(String url) async {
    var body = jsonEncode({"url": url});
    await post(
      Uri.parse("https://chapbuy.com/social-downloader/social-downloader/pinterest"),
      body: body,
      headers: {
        "Content-Type": "application/json",
      },
    ).then((value) {
      var data = jsonDecode(value.body);
      if (data['title'] != null) {
        dataModel = PinterestModel.fromJson(data);
      } else {
        if (data['message'].toString() != "null") {
          Get.snackbar("Error", data['message'].toString());
        }
      }
    }).catchError((err) {
      debugPrint("fetch error => $err");
    });
  }
}
