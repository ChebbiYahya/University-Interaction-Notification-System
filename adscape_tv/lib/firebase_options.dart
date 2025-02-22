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
    apiKey: 'AIzaSyAIcvcIDCkRnctc9-xSCrGLuZT9S0sNe0A',
    appId: '1:1076000056272:web:a8e853a6de0bd017bb0fd5',
    messagingSenderId: '1076000056272',
    projectId: 'adscape-4d666',
    authDomain: 'adscape-4d666.firebaseapp.com',
    storageBucket: 'adscape-4d666.appspot.com',
    measurementId: 'G-8D3GHJJZ40',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdYooIlzgZMItZDSuDl4Y8lIpmvSb7vug',
    appId: '1:1076000056272:android:dd5aeb59531d3cd9bb0fd5',
    messagingSenderId: '1076000056272',
    projectId: 'adscape-4d666',
    storageBucket: 'adscape-4d666.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBeoEUssEn1M_WfdsI7NHwAa8YayvtuElc',
    appId: '1:1076000056272:ios:5b6f272cff49bd2abb0fd5',
    messagingSenderId: '1076000056272',
    projectId: 'adscape-4d666',
    storageBucket: 'adscape-4d666.appspot.com',
    iosBundleId: 'com.example.adscapeTv',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAIcvcIDCkRnctc9-xSCrGLuZT9S0sNe0A',
    appId: '1:1076000056272:web:310c5ce34f919513bb0fd5',
    messagingSenderId: '1076000056272',
    projectId: 'adscape-4d666',
    authDomain: 'adscape-4d666.firebaseapp.com',
    storageBucket: 'adscape-4d666.appspot.com',
    measurementId: 'G-M6HW7480SQ',
  );
}
