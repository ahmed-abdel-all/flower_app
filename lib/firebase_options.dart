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
    apiKey: 'AIzaSyArUzidclDG6tMGTVnD_4hQ_IdznGpnDog',
    appId: '1:407070633717:web:1103ac1d0dc222d6ae5fbc',
    messagingSenderId: '407070633717',
    projectId: 'flower-app-66756',
    authDomain: 'flower-app-66756.firebaseapp.com',
    storageBucket: 'flower-app-66756.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC7KCdyDAbEsH3xARK-YLNFSl7HS1X5nj0',
    appId: '1:407070633717:android:8349e3a138bb020aae5fbc',
    messagingSenderId: '407070633717',
    projectId: 'flower-app-66756',
    storageBucket: 'flower-app-66756.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBKXc92hMZ2eZrA6qhAYjUSgcmiffeI-L0',
    appId: '1:407070633717:ios:cdeae0661ea9ae83ae5fbc',
    messagingSenderId: '407070633717',
    projectId: 'flower-app-66756',
    storageBucket: 'flower-app-66756.appspot.com',
    iosClientId: '407070633717-khoona7o3gdaf7a8hhbfi285usp9ask3.apps.googleusercontent.com',
    iosBundleId: 'com.example.flowerApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBKXc92hMZ2eZrA6qhAYjUSgcmiffeI-L0',
    appId: '1:407070633717:ios:cdeae0661ea9ae83ae5fbc',
    messagingSenderId: '407070633717',
    projectId: 'flower-app-66756',
    storageBucket: 'flower-app-66756.appspot.com',
    iosClientId: '407070633717-khoona7o3gdaf7a8hhbfi285usp9ask3.apps.googleusercontent.com',
    iosBundleId: 'com.example.flowerApp',
  );
}
