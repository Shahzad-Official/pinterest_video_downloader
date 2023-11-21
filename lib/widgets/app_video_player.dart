// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AppVideoPlayer extends StatefulWidget {
  final String url;
  final bool isFile;
  final bool isControlled;
  const AppVideoPlayer({
    Key? key,
    required this.url,
    this.isFile = false,
    this.isControlled = true,
  }) : super(key: key);

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  ChewieController? chewieController;
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    if (widget.isFile) {
      videoPlayerController = VideoPlayerController.file(
        File(widget.url),
      )..initialize().then((_) {
          setState(() {});
        });
    } else {
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.url),
      )..initialize().then((_) {
          setState(() {});
        });
    }
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
    );

    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    // chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!videoPlayerController.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: !widget.isControlled
                  ? VideoPlayer(videoPlayerController)
                  : Chewie(
                      controller: chewieController!,
                    ),
            )
          : Container();
    }
  }
}
