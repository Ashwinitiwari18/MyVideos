import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/constant.dart';
import 'package:getx_tutorial/controller/profile_controller.dart';
import 'package:getx_tutorial/view/widgets/video_player_item.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    log("1 ${widget.uid}");
    profileController.upDAteUserId(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        if (controller.user.isEmpty) {
          profileController.upDAteUserId(widget.uid);
          log("Inside loding : ${authController.user.uid}");
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black12,
            leading: const Icon(Icons.person_add_alt_1_outlined),
            actions: const [
              Padding(
                  padding: EdgeInsets.only(right: 18.0),
                  child: Icon(Icons.more_horiz))
            ],
            title: Text(
              controller.user['name'],
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: GestureDetector(
                              onTap: () {
                                _showVideoDailog(context, controller.user['profilePhoto'], false);
                              },
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: controller.user['profilePhoto'],
                                height: 100,
                                width: 100,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                controller.user['followers']?.toString() ?? '0',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'followers',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Container(
                            color: Colors.black54,
                            width: 1,
                            height: 15,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                          ),
                          Column(
                            children: [
                              Text(
                                controller.user['following']?.toString() ?? '0',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'following',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Container(
                            color: Colors.black54,
                            width: 1,
                            height: 15,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                          ),
                          Column(
                            children: [
                              Text(
                                controller.user['likes'],
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Likes',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 140,
                        height: 47,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                          ),
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              if (widget.uid == authController.user.uid) {
                                controller.signOut();
                              } else {
                                log(controller.user['isFollowing'].toString());
                                controller.followUser();
                              }
                            },
                            child: Text(
                              authController.user.uid == widget.uid
                                  ? 'Sign Out'
                                  : controller.user['isFollowing']
                                      ? "UnFollow"
                                      : "Follow",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.user['thumbnails'].length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 7,
                          mainAxisSpacing: 7,
                        ),
                        itemBuilder: (context, index) {
                          String thumbnail = controller.user['thumbnails'][
                              controller.user['thumbnails'].length - 1 - index];
                          String videoUrl = controller.user['videoUrls']
                              [controller.user['videoUrls'].length - 1 - index];
                          return GestureDetector(
                            onTap: () {
                              _showVideoDailog(context, videoUrl, true);
                            },
                            child: CachedNetworkImage(
                              imageUrl: thumbnail,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

void _showVideoDailog(BuildContext context, String url, bool flag) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: flag
              ? VideoPlayerItem(videoUrl: url)
              : CachedNetworkImage(imageUrl: url),
        ),
      );
    },
  );
}
