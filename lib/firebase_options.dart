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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDO1RoAl1BGrC5mh8eE2TBRD0c9Sr6kVTA',
    appId: '1:553142296135:web:da2a8c3a222155b8db5b62',
    messagingSenderId: '553142296135',
    projectId: 'chat-a0c4d',
    authDomain: 'chat-a0c4d.firebaseapp.com',
    databaseURL: 'https://chat-a0c4d-default-rtdb.firebaseio.com',
    storageBucket: 'chat-a0c4d.appspot.com',
    measurementId: 'G-B736B5Z1E9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCAuyJg9N55oa6sKdliKcORw72xenA2MFU',
    appId: '1:553142296135:android:3de6daccf00a3357db5b62',
    messagingSenderId: '553142296135',
    projectId: 'chat-a0c4d',
    databaseURL: 'https://chat-a0c4d-default-rtdb.firebaseio.com',
    storageBucket: 'chat-a0c4d.appspot.com',
  );
}
