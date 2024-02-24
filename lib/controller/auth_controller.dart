import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/constant.dart';
import 'package:getx_tutorial/model/user_model.dart' as model;
import 'package:getx_tutorial/view/screen/auth/login_screen.dart';
import 'package:getx_tutorial/view/screen/home_screen.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;
  late Rx<File?> _pickedImage = Rx<File?>(null);
  late final Rx<String> _profilePicDowloadUrl = Rx<String>('');

  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;
  String get profilePicDowloadUrl => _profilePicDowloadUrl.value;
  bool get isUserEmailverified => _user.value?.emailVerified ?? false;

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(const Duration(seconds: 2));
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    if (user == null || !user.emailVerified) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar("Image Picked", "You have succesfully pic image");
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    _profilePicDowloadUrl.value = downloadUrl;
    return downloadUrl;
  }

  // Register the User
  Future<void> registerUser(
      String userName, String email, String password, File? image) async {
    try {
      if (userName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
            name: userName,
            profilePhoto: downloadUrl,
            email: email,
            userId: cred.user!.uid);

        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        await cred.user!.sendEmailVerification();
        Get.snackbar("Account Successful",
            "Please check your email address to verify your account",
            duration: const Duration(seconds: 5));
      } else {
        Get.snackbar("Unsuccesful Attemt", "Please enter all the field");
      }
    } catch (e) {
      if (kDebugMode) {
        print("error : $e");
      }
      Get.snackbar("Error Creating Account", e.toString());
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential credResult = await firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password);
        User? user = credResult.user;
        if (user != null && user.emailVerified) {
          Get.offAll(() => HomeScreen());
        } else {
          await user!.sendEmailVerification();
          await firebaseAuth.signOut();
          Get.snackbar("Login Failed",
              "Please verify your email address before logging in.",
              duration: const Duration(seconds: 5));
        }
      }
    } catch (e) {
      Get.snackbar("Error in Log in", e.toString());
    }
  }

  void resendVerificationEmail() async {
    try {
      if (_user.value != null) {
        await _user.value!.sendEmailVerification();
        Get.snackbar("Email Resend",
            "Verification email has been resent. Please check your inbox.",
            duration: const Duration(seconds: 5));
      } else {
        Get.snackbar(
          "Error",
          "User not found. Please log in again.",
          duration: const Duration(seconds: 5),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to resend verification email. Please try again later.",
        duration: const Duration(seconds: 5),
      );
    }
  }

  Future<void> sendPassowrdResetEmail(String email) async {
    try {
      if (email.isNotEmpty) {
        await firebaseAuth.sendPasswordResetEmail(email: email);
        Get.snackbar("Password Reset Email",
            "Password Reset Email has been send. Please check your inbox.",
            duration: const Duration(seconds: 5));
      } else {
        Get.snackbar("Failed", "Enter Email");
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to send Reset Password email. Please try again later.",
        duration: const Duration(seconds: 5),
      );
    }
  }
}
