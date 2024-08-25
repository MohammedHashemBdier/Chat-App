// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDAjD8mgdYRqidoMybtkUf2TYg1AlUVycE',
    appId: '1:177512817808:web:afcf2cf4aa0656f620a415',
    messagingSenderId: '177512817808',
    projectId: 'chat-app-47d38',
    authDomain: 'chat-app-47d38.firebaseapp.com',
    storageBucket: 'chat-app-47d38.appspot.com',
    measurementId: 'G-DCXVNEJ89C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4_YplNm6hz4QRycsUfxCGhv27sI7Bbbg',
    appId: '1:177512817808:android:149965ef78f0617e20a415',
    messagingSenderId: '177512817808',
    projectId: 'chat-app-47d38',
    storageBucket: 'chat-app-47d38.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJ3a5U15cpWFU_lPvjj0qqT08j3kOCETk',
    appId: '1:177512817808:ios:a9cea8a56399001620a415',
    messagingSenderId: '177512817808',
    projectId: 'chat-app-47d38',
    storageBucket: 'chat-app-47d38.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBJ3a5U15cpWFU_lPvjj0qqT08j3kOCETk',
    appId: '1:177512817808:ios:a9cea8a56399001620a415',
    messagingSenderId: '177512817808',
    projectId: 'chat-app-47d38',
    storageBucket: 'chat-app-47d38.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDAjD8mgdYRqidoMybtkUf2TYg1AlUVycE',
    appId: '1:177512817808:web:04bd50d9e574c7f420a415',
    messagingSenderId: '177512817808',
    projectId: 'chat-app-47d38',
    authDomain: 'chat-app-47d38.firebaseapp.com',
    storageBucket: 'chat-app-47d38.appspot.com',
    measurementId: 'G-WR6JW3GWEN',
  );
}
