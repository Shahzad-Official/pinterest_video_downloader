import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinterest_video_downloader/constants/app_spacing.dart';
import 'package:pinterest_video_downloader/views/home/controllers/home_controller.dart';
import 'package:pinterest_video_downloader/widgets/app_text.dart';
import 'package:pinterest_video_downloader/widgets/app_video_player.dart';

class Download extends StatefulWidget {
  const Download({super.key});

  @override
  State<Download> createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  final HomeController _controller = Get.put(HomeController());

  @override
  void initState() {
    _controller.hasError = false;
    Permission.manageExternalStorage.request();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _controller.cancelDownload();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: AppText(
            text: "Download File",
          ),
        ),
        body: SafeArea(
          child: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (_) {
              return Column(
                children: [
                  AppSpacing.heightspace10,
                  Center(
                    child: AppText(
                      text: _.data.title.toString(),
                    ),
                  ),
                  AppSpacing.heightspace10,
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
                  AppSpacing.heightspace10,
                  _.isDownloading
                      ? Column(
                          children: [
                            AppText(
                              text: "Downloading  ${(_.progress * 100).toStringAsFixed(0)}%",
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                            AppSpacing.heightspace5,
                            Row(
                              children: [
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: _.progress,
                                    minHeight: 7,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _.cancelDownload();
                                  },
                                  icon: Icon(Icons.close),
                                ),
                              ],
                            ),
                            AppSpacing.heightspace10,
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
                          child: AppText(
                            text: "Download Video",
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                  ElevatedButton(
                    onPressed: _.isDownloading
                        ? () {}
                        : () async {
                            await _.downloadImage(context);
                          },
                    child: AppText(
                      text: "Download Thumbnail",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
