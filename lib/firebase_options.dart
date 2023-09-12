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
    apiKey: 'AIzaSyD5zl0gRa_YNqUUpT7nBTem2dr_3p7Zrew',
    appId: '1:286259188695:web:83d561304157e73a883192',
    messagingSenderId: '286259188695',
    projectId: 'beerchart-7adb2',
    authDomain: 'beerchart-7adb2.firebaseapp.com',
    storageBucket: 'beerchart-7adb2.appspot.com',
    measurementId: 'G-6GPG3FXT4S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJP0ps2Wvmes15YDtDikzuL67RADKA1UA',
    appId: '1:286259188695:android:8a418eb23a8d0cca883192',
    messagingSenderId: '286259188695',
    projectId: 'beerchart-7adb2',
    storageBucket: 'beerchart-7adb2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxAIlTD4L-i1iu3ewy4dvs1fuOSnwwjhI',
    appId: '1:286259188695:ios:48720f1d751b9c07883192',
    messagingSenderId: '286259188695',
    projectId: 'beerchart-7adb2',
    storageBucket: 'beerchart-7adb2.appspot.com',
    iosBundleId: 'com.mellonn.beerapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCxAIlTD4L-i1iu3ewy4dvs1fuOSnwwjhI',
    appId: '1:286259188695:ios:ecb59a581cc9f14e883192',
    messagingSenderId: '286259188695',
    projectId: 'beerchart-7adb2',
    storageBucket: 'beerchart-7adb2.appspot.com',
    iosBundleId: 'com.mellonn.beerapp.RunnerTests',
  );
}
