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
        return web;
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
    apiKey: 'AIzaSyDPjgjcio3HENDM9CsxjVuioDhO8_aXiQw',
    appId: '1:419864477163:web:fb2a93ddd4cc90444dedae',
    messagingSenderId: '419864477163',
    projectId: 'aquae-florentis',
    authDomain: 'aquae-florentis.firebaseapp.com',
    storageBucket: 'aquae-florentis.appspot.com',
    measurementId: 'G-5XXCSHR4DE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfTZVsuQ2CKhEGPYuSXvF9HOMoPsuKvKE',
    appId: '1:419864477163:android:dea701d919429bd24dedae',
    messagingSenderId: '419864477163',
    projectId: 'aquae-florentis',
    storageBucket: 'aquae-florentis.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqYrgieAnwjJsnTIdwYSlNQJLbzXbLHSU',
    appId: '1:419864477163:ios:2e998bb5074988d84dedae',
    messagingSenderId: '419864477163',
    projectId: 'aquae-florentis',
    storageBucket: 'aquae-florentis.appspot.com',
    iosClientId: '419864477163-htnc0kqvnv2k40q34ffdtdr9n6khstgb.apps.googleusercontent.com',
    iosBundleId: 'com.example.aquaeFlorentis',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCqYrgieAnwjJsnTIdwYSlNQJLbzXbLHSU',
    appId: '1:419864477163:ios:ecf06833aa96fbe54dedae',
    messagingSenderId: '419864477163',
    projectId: 'aquae-florentis',
    storageBucket: 'aquae-florentis.appspot.com',
    iosClientId: '419864477163-q9e42qt5ulc0gchpgn1co03thr4hncme.apps.googleusercontent.com',
    iosBundleId: 'com.example.aquaeFlorentis.RunnerTests',
  );
}
