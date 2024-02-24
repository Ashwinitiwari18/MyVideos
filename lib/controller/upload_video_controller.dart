import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/constant.dart';
import 'package:getx_tutorial/model/video.dart';
import 'package:getx_tutorial/view/screen/home_screen.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  MediaInfo? _currentCompression;
  _compressVideo(String videoPath) async {
    if (_currentCompression == null) {
      _currentCompression = await VideoCompress.compressVideo(videoPath,
          quality: VideoQuality.MediumQuality);

      if (_currentCompression != null) {
        return _currentCompression!.file;
      } else {
        _currentCompression = null;
        throw Exception("Video compression failed");
      }
    } else {
      throw Exception("Compression process already in progress");
    }
  }

  Future<String> _uploadVideoToStorage(String id, String filePath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);
    UploadTask uploadTask = ref.putFile(await _compressVideo(filePath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child("thumbnails").child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      Get.offAll(HomeScreen(pageIdx: 2,));
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection("users").doc(uid).get();
      var allDocs = await firestore.collection("videos").get();
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage("video $len", videoPath);
      String thumbnail = await _uploadImageToStorage("Video $len", videoPath);
      Video video = Video(
        userName: (userDoc.data()! as Map<String, dynamic>)['name'],
        uid: uid,
        id: "Video $len",
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
        thumbnail: thumbnail,
      );
      await firestore
          .collection("videos")
          .doc("Video $len")
          .set(video.toJson());
      log("Back again 1");
      log("Back again 2");
    } catch (e) {
      Get.snackbar("Upload Video Error", e.toString());
    }
  }
}
