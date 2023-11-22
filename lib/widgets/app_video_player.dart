// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinterest_video_downloader/views/home/controllers/home_controller.dart';
import 'package:pinterest_video_downloader/widgets/app_text.dart';

import 'package:video_player/video_player.dart';

class AppVideoPlayer extends StatefulWidget {
  final String url;
  final bool isFile;
  final bool isControlled;
  final double? aspectRatio;
  const AppVideoPlayer({
    Key? key,
    required this.url,
    this.isFile = false,
    this.isControlled = true,
    this.aspectRatio,
  }) : super(key: key);

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  ChewieController? chewieController;
  late VideoPlayerController videoPlayerController;
  bool hasError = false;

  @override
  void initState() {
    if (widget.isFile) {
      videoPlayerController = VideoPlayerController.file(
        File(widget.url),
      )..initialize().then((_) {
          setState(() {
            chewieController = ChewieController(
              videoPlayerController: videoPlayerController,
              autoPlay: false,
              looping: true,
            );
          });
        });
    } else {
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.url),
      )..initialize().then((_) {
          Get.find<HomeController>().changeError(false);
          setState(() {
            chewieController = ChewieController(
              videoPlayerController: videoPlayerController,
              autoPlay: false,
              looping: true,
            );
          });
        }).catchError((err) {
          setState(() {
            hasError = true;
          });
          Get.find<HomeController>().changeError(true);
        });
    }

    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    if (chewieController != null) {
      chewieController!.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return const Center(
        child: AppText(
          text: "No Video Found on this Url",
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      );
    } else if (!videoPlayerController.value.isInitialized || chewieController == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: widget.aspectRatio ?? videoPlayerController.value.aspectRatio,
              child: !widget.isControlled
                  ? Center(
                      child: VideoPlayer(videoPlayerController),
                    )
                  : Chewie(
                      controller: chewieController!,
                    ),
            )
          : Container();
    }
  }
}
