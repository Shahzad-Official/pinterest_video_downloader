import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinterest_video_downloader/views/home/controllers/home_controller.dart';

class DownloadTab extends StatelessWidget {
  const DownloadTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) {
        return Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _.url,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                hintText: "Paste Your Link Here...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(70),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _.isLoading
                  ? () {}
                  : () async {
                      await _.getData();
                    },
              child: _.isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      "Download",
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView(
              shrinkWrap: true,
              children: const [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Frequently Asked Questions (FAQs)",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ExpansionTile(
                  title: Text(
                    "1. Is Pinterest Downloader safe to use?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  children: [
                    Text(
                      "Pinterest Downloader prioritises user safety and employs security measures to protect your data.",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    "2. What formats are supported for video downloads?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  children: [
                    Text(
                      "Pinterest Downloader supports MP4 format for high-definition video downloads.",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    "3. Do I need to register or pay to use Pinterest Downloader?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  children: [
                    Text(
                      "No, the tool is free, and no registration or fees are required.",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    "4. Can I download content on mobile devices?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  children: [
                    Text(
                      "Pinterest Downloader is compatible with computers, tablets, and mobile devices.",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 0,
            ),
          ],
        );
      },
    );
  }
}
