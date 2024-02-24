import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/constant.dart';
import 'package:getx_tutorial/model/video.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);
  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(
      firestore.collection("videos").snapshots().map(
        (QuerySnapshot query) {
          List<Video> retval = [];
          for (var value in query.docs) {
            retval.add(Video.fromSnap(value));
          }
          return retval;
        },
      ),
    );
  }

  likeVideo(String id) async {
    log(id);
    DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
    var uid = authController.user.uid;
    log(uid);
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      log("1");
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      log("2");
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }
}
