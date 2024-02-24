// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDUSGWIOV1RX3TGYa7kW8IrOyHRXBwHeTU',
    appId: '1:424364782780:web:cf8e8ea16cdb38fd210cb9',
    messagingSenderId: '424364782780',
    projectId: 'my-videos-cda70',
    authDomain: 'my-videos-cda70.firebaseapp.com',
    storageBucket: 'my-videos-cda70.appspot.com',
    measurementId: 'G-YWZ13R39GT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDFj72hUdIUadQdhhIMLFWljFkkp-1ZE-E',
    appId: '1:424364782780:android:cd6c0b09a6fb1b07210cb9',
    messagingSenderId: '424364782780',
    projectId: 'my-videos-cda70',
    storageBucket: 'my-videos-cda70.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDbLxhz289rOdLhZmlKQar4p0yl3bRA6P8',
    appId: '1:424364782780:ios:873d7906876325f2210cb9',
    messagingSenderId: '424364782780',
    projectId: 'my-videos-cda70',
    storageBucket: 'my-videos-cda70.appspot.com',
    iosBundleId: 'com.example.getxTutorial',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDbLxhz289rOdLhZmlKQar4p0yl3bRA6P8',
    appId: '1:424364782780:ios:b4bd76d33fd383fc210cb9',
    messagingSenderId: '424364782780',
    projectId: 'my-videos-cda70',
    storageBucket: 'my-videos-cda70.appspot.com',
    iosBundleId: 'com.example.getxTutorial.RunnerTests',
  );
}
