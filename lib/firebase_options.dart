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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbjJ4t5xlVrqO0qafkMOS30g2YhzbtRqk',
    appId: '1:909193162517:android:3c159d9c6145f1860e831c',
    messagingSenderId: '909193162517',
    projectId: 'girdharidb',
    storageBucket: 'girdharidb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBuCY7d8ABhR2yp09daqvIipoMLQ6S5Tcc',
    appId: '1:909193162517:ios:b1f05a39c25b08490e831c',
    messagingSenderId: '909193162517',
    projectId: 'girdharidb',
    storageBucket: 'girdharidb.appspot.com',
    iosBundleId: 'com.example.girdhari',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCksLRNtaSvq8K7CkL9zRNcAGgaav3BjhI',
    appId: '1:909193162517:web:8f22774f543787f30e831c',
    messagingSenderId: '909193162517',
    projectId: 'girdharidb',
    authDomain: 'girdharidb.firebaseapp.com',
    storageBucket: 'girdharidb.appspot.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBuCY7d8ABhR2yp09daqvIipoMLQ6S5Tcc',
    appId: '1:909193162517:ios:b1f05a39c25b08490e831c',
    messagingSenderId: '909193162517',
    projectId: 'girdharidb',
    storageBucket: 'girdharidb.appspot.com',
    iosBundleId: 'com.example.girdhari',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCksLRNtaSvq8K7CkL9zRNcAGgaav3BjhI',
    appId: '1:909193162517:web:1401424e7e9cf9cc0e831c',
    messagingSenderId: '909193162517',
    projectId: 'girdharidb',
    authDomain: 'girdharidb.firebaseapp.com',
    storageBucket: 'girdharidb.appspot.com',
  );

}