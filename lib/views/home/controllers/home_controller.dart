import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinterest_video_downloader/utils/storage_utils.dart';
import 'package:pinterest_video_downloader/views/download/download.dart';
import 'package:pinterest_video_downloader/views/home/data/fetch_data.dart';
import 'package:pinterest_video_downloader/views/home/home_view.dart';
import 'package:pinterest_video_downloader/views/home/models/pinterest_model.dart';

class HomeController extends GetxController {
  TextEditingController url = TextEditingController();
  final FetchData _fetchData = FetchData();
  PinterestModel data = PinterestModel();
  bool isLoading = false;
  getData() async {
    data = PinterestModel();
    hasError = false;
    isLoading = true;
    update();
    await _fetchData.fetchData(url.text);
    data = _fetchData.dataModel;
    isLoading = false;
    update();
    Get.to(
      () => const Download(),
    );
  }

  bool hasError = false;
  changeError(bool value) {
    hasError = value;
    update();
  }

  bool isDownloading = false;
  double progress = 0.0;
  downloadVideo(context) async {
    cancelToken = CancelToken();
    progress = 0.0;
    update();
    isDownloading = true;
    update();
    var path = await StorageUtils.createFolder();
    String fileName = data.video.toString().split("/").last;

    await Dio().download(
      data.video.toString(),
      "${path.path}$fileName",
      cancelToken: cancelToken,
      onReceiveProgress: (count, total) {
        progress = count / total;
        update();
      },
    ).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("File has been Downloaded Successfully"),
        ),
      );
      url.text = "";
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ));
    }).catchError((err) {
      debugPrint(err.toString());
    });
    isDownloading = false;
    update();
  }

  CancelToken cancelToken = CancelToken();
  cancelDownload() {
    cancelToken.cancel();
    isDownloading = false;
    update();
  }

  downloadImage(context) async {
    cancelToken = CancelToken();
    progress = 0.0;
    update();
    isDownloading = true;
    update();
    var path = await StorageUtils.createFolder();
    String fileName = data.thumbnail!.url.toString().split("/").last;

    await Dio().download(
      data.thumbnail!.url.toString(),
      "${path.path}$fileName",
      cancelToken: cancelToken,
      onReceiveProgress: (count, total) {
        progress = count / total;
        update();
      },
    ).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("File has been Downloaded Successfully"),
        ),
      );
      url.text = "";
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ));
    }).catchError((err) {
      debugPrint(err.toString());
    });
    isDownloading = false;
    update();
  }
}
