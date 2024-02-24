import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/controller/video_controller.dart';
import 'package:getx_tutorial/model/video.dart';
import 'package:getx_tutorial/view/screen/comment_screen.dart';
import 'package:getx_tutorial/view/widgets/circle_animation.dart';
import 'package:getx_tutorial/view/widgets/video_player_item.dart';

class SearchScreenFeed extends StatelessWidget {
  SearchScreenFeed({super.key});

  final VideoController videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: videoController.videoList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 7,
          mainAxisSpacing: 7,
        ),
        itemBuilder: (context, index) {
          final data = videoController
              .videoList[videoController.videoList.length - 1 - index];
          return GestureDetector(
            onTap: () {
              getVideo(data, context);
            },
            child: CachedNetworkImage(
              imageUrl: data.thumbnail,
              fit: BoxFit.cover,
            ),
          );
        });
  }

  getVideo(Video data, BuildContext context) {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) => Stack(
        children: [
          VideoPlayerItem(videoUrl: data.videoUrl),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          data.userName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          data.caption,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.music_note,
                              size: 15,
                              color: Colors.white,
                            ),
                            Text(
                              data.songName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  margin: EdgeInsets.only(top: size.height / 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildProfile(data.profilePhoto),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => CommentScreen(
                                        id: data.id,
                                      )),
                            ),
                            child: const Icon(
                              Icons.comment,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            data.commentCount.toString(),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.reply,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            data.shareCount.toString(),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          )
                        ],
                      ),
                      CircleAnimation(
                        child: buildMusicAlbum(data.profilePhoto),
                      ),  
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildProfile(String profileName) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profileName),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.grey,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(profilePhoto),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
