import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/constant.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;
  Rx<String> _uid = ''.obs;
  upDAteUserId(String id) {
    _uid.value = id;
    update();
    getUserData();
  }

  getUserData() async {
    List<String> thumbnails = [],videoUrls=[];
    QuerySnapshot myVideos = await firestore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();
    for (var i = 0; i < myVideos.docs.length; i++) {
      thumbnails
          .add((myVideos.docs[i].data() as Map<String, dynamic>)['thumbnail']);
      videoUrls
          .add((myVideos.docs[i].data() as Map<String, dynamic>)['videoUrl']);
    }

    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();
    final userData = userDoc.data()! as dynamic;
    String name = userData['name'];
    String profilePhoto = userDoc['profilePhoto'];
    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;

    for (var item in myVideos.docs) {
      likes +=
          ((item.data() as Map<String, dynamic>)['likes'] as List?)?.length ??
              0;
    }

    var followersDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();
    var followingDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();
    followers = followersDoc.docs.length;
    following = followingDoc.docs.length;

    await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });

    _user.value = {
      'name': name,
      'following': following.toString(),
      'followers': followers.toString(),
      'isFollowing': isFollowing,
      'profilePhoto': profilePhoto,
      'likes': likes.toString(),
      'thumbnails': thumbnails,
      'videoUrls':videoUrls,
    };
    update();
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }

  void followUser() async {
    var doc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get();
    if (!doc.exists) {
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .set({});
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .set({});
      _user.value.update(
        'followers',
        (value) => (int.parse(value) + 1).toString(),
      );
    } else {
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .delete();
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .delete();
      _user.value.update(
        'followers',
        (value) => (int.parse(value) - 1).toString(),
      );
    }
    log(_user.value['isFollowing'].toString());
    update();
    _user.value.update('isFollowing', (value) => !value);
    update();
    log(_user.value['isFollowing'].toString());
  }
}
