import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinterest_video_downloader/constants/app_spacing.dart';
import 'package:pinterest_video_downloader/views/about_us/about_us.dart';
import 'package:pinterest_video_downloader/views/contact_us/contact_us.dart';
import 'package:pinterest_video_downloader/views/home/views/download_tab.dart';
import 'package:pinterest_video_downloader/views/home/views/saved.dart';
import 'package:pinterest_video_downloader/widgets/app_text.dart';

Permission permission = Permission.storage;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  late TabController _tabController;

  getDeviceInfo() async {
    AndroidDeviceInfo androidDeviceInfo = await _deviceInfoPlugin.androidInfo;
    // String? token = await FirebaseMessaging.instance.getToken();
    // print(token);
    print(androidDeviceInfo.id);
  }

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    Permission.manageExternalStorage.request();
    getDeviceInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const AppText(text: "Pinterest Downloader"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    Get.to(
                      () => const AboutUs(),
                    );
                  },
                  child: const AppText(
                    text: "About Us",
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    Get.to(
                      () => const ContactUs(),
                    );
                  },
                  child: const AppText(
                    text: "Contact Us",
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: "Download",
              ),
              Tab(
                text: "Saved",
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: TabBarView(
                controller: _tabController,
                children: const [
                  DownloadTab(),
                  Saved(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 5,
        ),
        child: OutlinedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const AppText(
                        text: "How to Download Pinterest Videos or Images ?",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      AppSpacing.heightspace10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/Image0.jpeg",
                                  width: MediaQuery.of(context).size.width * 0.3,
                                ),
                                AppSpacing.heightspace5,
                                const AppText(
                                  text: "1. Copy Link from Pinterest",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/Image1.jpeg",
                                  width: MediaQuery.of(context).size.width * 0.3,
                                ),
                                AppSpacing.heightspace5,
                                const AppText(
                                  text: "2. Paste the copied Link",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/Image0.jpeg",
                                  width: MediaQuery.of(context).size.width * 0.3,
                                ),
                                AppSpacing.heightspace5,
                                const AppText(
                                  text: "3. Save File in your Device",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const AppText(
            text: "Get Some Help ?",
          ),
        ),
      ),
    );
  }
}
