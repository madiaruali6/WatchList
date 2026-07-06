import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are configured for Android and iOS only.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB0joqIWuYhEWqhsH37EJbdNlTYTDhoYTo',
    appId: '1:1009854765526:android:7380c4f61489145394ec77',
    messagingSenderId: '1009854765526',
    projectId: 'madiyar-test-app',
    storageBucket: 'madiyar-test-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0joqIWuYhEWqhsH37EJbdNlTYTDhoYTo',
    appId: '1:1009854765526:ios:f3659ab975f2faa394ec77',
    messagingSenderId: '1009854765526',
    projectId: 'madiyar-test-app',
    storageBucket: 'madiyar-test-app.firebasestorage.app',
    iosBundleId: 'com.example.watchlistapp',
  );
}
