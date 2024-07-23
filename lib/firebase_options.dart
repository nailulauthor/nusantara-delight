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
    apiKey: 'AIzaSyAtPgPCVV9WkgUQ-NYM1Ql94PzuKEUt68k',
    appId: '1:49377129622:web:dd3b817d7e1ee038b7beb7',
    messagingSenderId: '49377129622',
    projectId: 'nusantaradelight-91753',
    authDomain: 'nusantaradelight-91753.firebaseapp.com',
    storageBucket: 'nusantaradelight-91753.appspot.com',
    measurementId: 'G-9K5FS1SNW6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmFBuGHLmRN-y0A75V0Nthju6nPRUvMNk',
    appId: '1:49377129622:android:a375e2b3b4299930b7beb7',
    messagingSenderId: '49377129622',
    projectId: 'nusantaradelight-91753',
    storageBucket: 'nusantaradelight-91753.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAuJU3WgeQumTrnXU7Murbu4_qr-pYDqrc',
    appId: '1:49377129622:ios:c524d95df4a448e9b7beb7',
    messagingSenderId: '49377129622',
    projectId: 'nusantaradelight-91753',
    storageBucket: 'nusantaradelight-91753.appspot.com',
    iosBundleId: 'com.example.nusantaraDelight',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAuJU3WgeQumTrnXU7Murbu4_qr-pYDqrc',
    appId: '1:49377129622:ios:c524d95df4a448e9b7beb7',
    messagingSenderId: '49377129622',
    projectId: 'nusantaradelight-91753',
    storageBucket: 'nusantaradelight-91753.appspot.com',
    iosBundleId: 'com.example.nusantaraDelight',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAtPgPCVV9WkgUQ-NYM1Ql94PzuKEUt68k',
    appId: '1:49377129622:web:084d5b97fbd76a34b7beb7',
    messagingSenderId: '49377129622',
    projectId: 'nusantaradelight-91753',
    authDomain: 'nusantaradelight-91753.firebaseapp.com',
    storageBucket: 'nusantaradelight-91753.appspot.com',
    measurementId: 'G-M68YKN83X7',
  );
}
