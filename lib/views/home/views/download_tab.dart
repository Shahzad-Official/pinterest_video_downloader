import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinterest_video_downloader/constants/app_spacing.dart';
import 'package:pinterest_video_downloader/views/home/controllers/home_controller.dart';
import 'package:pinterest_video_downloader/widgets/app_text.dart';

class DownloadTab extends StatelessWidget {
  const DownloadTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) {
        return ListView(
          children: [
            AppSpacing.heightspace20,
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
            AppSpacing.heightspace20,
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
                  : const AppText(
                      text: "Download",
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
            ),
            AppSpacing.heightspace20,
            AppSpacing.heightspace20,
            AppText(
              text: "Frequently Asked Questions (FAQs)",
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            ExpansionTile(
              title: AppText(
                text: "1. Is Pinterest Downloader safe to use?",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              children: [
                AppText(
                  text: "Pinterest Downloader prioritises user safety and employs security measures to protect your data.",
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                AppSpacing.heightspace10,
              ],
            ),
            ExpansionTile(
              title: AppText(
                text: "2. What formats are supported for video downloads?",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              children: [
                AppText(
                  text: "Pinterest Downloader supports MP4 format for high-definition video downloads.",
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                AppSpacing.heightspace10,
              ],
            ),
            ExpansionTile(
              title: AppText(
                text: "3. Do I need to register or pay to use Pinterest Downloader?",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              children: [
                AppText(
                  text: "No, the tool is free, and no registration or fees are required.",
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                AppSpacing.heightspace10,
              ],
            ),
            ExpansionTile(
              title: AppText(
                text: "4. Can I download content on mobile devices?",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              children: [
                AppText(
                  text: "Pinterest Downloader is compatible with computers, tablets, and mobile devices.",
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                AppSpacing.heightspace10,
              ],
            ),
            AppSpacing.heightspace20,
          ],
        );
      },
    );
  }
}
