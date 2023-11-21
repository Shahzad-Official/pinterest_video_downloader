import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinterest_video_downloader/views/home/controllers/home_controller.dart';
import 'package:pinterest_video_downloader/widgets/app_video_player.dart';

class Download extends StatefulWidget {
  const Download({super.key});

  @override
  State<Download> createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  @override
  void initState() {
    Permission.manageExternalStorage.request();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (_) {
            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    _.data.title.toString(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                _.data.video == ""
                    ? Expanded(
                        child: Image.network(
                          _.data.thumbnail!.url.toString(),
                        ),
                      )
                    : Expanded(
                        child: AppVideoPlayer(
                          url: _.data.video.toString(),
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                _.isDownloading
                    ? Column(
                        children: [
                          Text(
                            "Downloading  ${(_.progress * 100).toStringAsFixed(0)}%",
                            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          LinearProgressIndicator(
                            value: _.progress,
                            minHeight: 7,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    : const SizedBox(),
                _.data.video == ""
                    ? const SizedBox()
                    : ElevatedButton(
                        onPressed: _.isDownloading
                            ? () {}
                            : () async {
                                await _.downloadVideo(context);
                              },
                        child: const Text(
                          "Download Video",
                        ),
                      ),
                ElevatedButton(
                  onPressed: _.isDownloading
                      ? () {}
                      : () async {
                          await _.downloadImage(context);
                        },
                  child: const Text(
                    "Download Thumbnail",
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
