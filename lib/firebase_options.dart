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
    apiKey: 'AIzaSyCj7NV_1PJ4j97fgIKFL1sZZvcUI_g-y_c',
    appId: '1:958659977974:web:e5f351c300aeed4ff642d7',
    messagingSenderId: '958659977974',
    projectId: 'pet-app-second-project',
    authDomain: 'pet-app-second-project.firebaseapp.com',
    storageBucket: 'pet-app-second-project.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD0yL5JpBv443ej9_T-IJvlLHZ1J75hucA',
    appId: '1:958659977974:android:8720e99118784b0ef642d7',
    messagingSenderId: '958659977974',
    projectId: 'pet-app-second-project',
    storageBucket: 'pet-app-second-project.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCj7NV_1PJ4j97fgIKFL1sZZvcUI_g-y_c',
    appId: '1:958659977974:web:623fa4a0079e8e78f642d7',
    messagingSenderId: '958659977974',
    projectId: 'pet-app-second-project',
    authDomain: 'pet-app-second-project.firebaseapp.com',
    storageBucket: 'pet-app-second-project.firebasestorage.app',
  );
}
