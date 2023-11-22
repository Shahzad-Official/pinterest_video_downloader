import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinterest_video_downloader/utils/storage_utils.dart';
import 'package:pinterest_video_downloader/widgets/app_text.dart';
import 'package:pinterest_video_downloader/widgets/app_video_player.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  List<FileSystemEntity> files = [];
  bool isLoading = false;
  getData() async {
    setState(() {
      isLoading = true;
    });
    files = await StorageUtils.getFiles();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    Permission.manageExternalStorage.request();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (files.isEmpty) {
      return const Center(
        child: AppText(
          text: "No files found!",
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      );
    } else {
      return GridView.builder(
        itemCount: files.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          if (files[index].path.contains(".mp4")) {
            return InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      icon: const Align(
                        alignment: Alignment.topRight,
                        child: CloseButton(),
                      ),
                      content: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: AppVideoPlayer(
                          url: files[index].path,
                          isFile: true,
                        ),
                      ),
                    );
                  },
                );
              },
              child: Stack(
                children: [
                  AppVideoPlayer(
                    url: files[index].path,
                    isFile: true,
                    isControlled: false,
                  ),
                  const Center(
                    child: FloatingActionButton(
                      onPressed: null,
                      child: Icon(Icons.play_arrow),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      icon: const Align(
                        alignment: Alignment.topRight,
                        child: CloseButton(),
                      ),
                      content: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Image.file(
                          File(files[index].path),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Image.file(
                File(files[index].path),
                fit: BoxFit.cover,
              ),
            );
          }
        },
      );
    }
  }
}
