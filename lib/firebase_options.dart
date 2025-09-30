// Firebase configuration with environment variables
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
        return linux;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // Função auxiliar para obter variáveis de ambiente com fallback
  static String _getEnvVar(String key, String fallback) {
    try {
      final value = dotenv.env[key];
      return value?.isNotEmpty == true ? value! : fallback;
    } catch (e) {
      return fallback;
    }
  }

  static FirebaseOptions get web => FirebaseOptions(
    apiKey: _getEnvVar('FIREBASE_WEB_API_KEY', 'AIzaSyCa28-JO6_B7ySO_x5gSaeEreGGXy1o358'),
    appId: _getEnvVar('FIREBASE_WEB_APP_ID', '1:843407503335:web:58ad5040db096fbe071742'),
    messagingSenderId: _getEnvVar('FIREBASE_MESSAGING_SENDER_ID', '843407503335'),
    projectId: _getEnvVar('FIREBASE_PROJECT_ID', 'takatsu-projects'),
    authDomain: _getEnvVar('FIREBASE_AUTH_DOMAIN', 'takatsu-projects.firebaseapp.com'),
    storageBucket: _getEnvVar('FIREBASE_STORAGE_BUCKET', 'takatsu-projects.firebasestorage.app'),
    measurementId: _getEnvVar('FIREBASE_MEASUREMENT_ID', 'G-FWR3B90F6M'),
  );

  static FirebaseOptions get android => FirebaseOptions(
    apiKey: _getEnvVar('FIREBASE_ANDROID_API_KEY', 'AIzaSyBunaqAIxrMyP1qeK5YzzM7R1KUiQr-yno'),
    appId: _getEnvVar('FIREBASE_ANDROID_APP_ID', '1:843407503335:android:24480c81f52c49c6071742'),
    messagingSenderId: _getEnvVar('FIREBASE_MESSAGING_SENDER_ID', '843407503335'),
    projectId: _getEnvVar('FIREBASE_PROJECT_ID', 'takatsu-projects'),
    storageBucket: _getEnvVar('FIREBASE_STORAGE_BUCKET', 'takatsu-projects.firebasestorage.app'),
  );

  static FirebaseOptions get ios => FirebaseOptions(
    apiKey: _getEnvVar('FIREBASE_IOS_API_KEY', 'AIzaSyDTB6XT7-B4Y_AbJQLDmVJnTquO6JrnvyY'),
    appId: _getEnvVar('FIREBASE_IOS_APP_ID', '1:843407503335:ios:8186f70895031d24071742'),
    messagingSenderId: _getEnvVar('FIREBASE_MESSAGING_SENDER_ID', '843407503335'),
    projectId: _getEnvVar('FIREBASE_PROJECT_ID', 'takatsu-projects'),
    storageBucket: _getEnvVar('FIREBASE_STORAGE_BUCKET', 'takatsu-projects.firebasestorage.app'),
    iosClientId: _getEnvVar('FIREBASE_IOS_CLIENT_ID', '843407503335-5mkhb2ufjlhnad3g5br74iq9httmllrg.apps.googleusercontent.com'),
    iosBundleId: _getEnvVar('FIREBASE_IOS_BUNDLE_ID', 'com.example.conectarApp'),
  );

  static FirebaseOptions get macos => FirebaseOptions(
    apiKey: _getEnvVar('FIREBASE_IOS_API_KEY', 'AIzaSyDTB6XT7-B4Y_AbJQLDmVJnTquO6JrnvyY'),
    appId: _getEnvVar('FIREBASE_IOS_APP_ID', '1:843407503335:ios:8186f70895031d24071742'),
    messagingSenderId: _getEnvVar('FIREBASE_MESSAGING_SENDER_ID', '843407503335'),
    projectId: _getEnvVar('FIREBASE_PROJECT_ID', 'takatsu-projects'),
    storageBucket: _getEnvVar('FIREBASE_STORAGE_BUCKET', 'takatsu-projects.firebasestorage.app'),
    iosClientId: _getEnvVar('FIREBASE_IOS_CLIENT_ID', '843407503335-5mkhb2ufjlhnad3g5br74iq9httmllrg.apps.googleusercontent.com'),
    iosBundleId: _getEnvVar('FIREBASE_IOS_BUNDLE_ID', 'com.example.conectarApp'),
  );

  static FirebaseOptions get windows => FirebaseOptions(
    apiKey: _getEnvVar('FIREBASE_WINDOWS_API_KEY', 'AIzaSyA6f8FMvBzPqu8o6MpS5Rj4F3jflVS6PpY'),
    appId: _getEnvVar('FIREBASE_WINDOWS_APP_ID', '1:843407503335:web:8287f203896de5c0071742'),
    messagingSenderId: _getEnvVar('FIREBASE_MESSAGING_SENDER_ID', '843407503335'),
    projectId: _getEnvVar('FIREBASE_PROJECT_ID', 'takatsu-projects'),
    authDomain: _getEnvVar('FIREBASE_AUTH_DOMAIN', 'takatsu-projects.firebaseapp.com'),
    storageBucket: _getEnvVar('FIREBASE_STORAGE_BUCKET', 'takatsu-projects.firebasestorage.app'),
    measurementId: _getEnvVar('FIREBASE_WINDOWS_MEASUREMENT_ID', 'G-3W3HSYRZ7Y'),
  );

  static FirebaseOptions get linux => FirebaseOptions(
    apiKey: _getEnvVar('FIREBASE_WEB_API_KEY', 'AIzaSyCa28-JO6_B7ySO_x5gSaeEreGGXy1o358'),
    appId: _getEnvVar('FIREBASE_WEB_APP_ID', '1:843407503335:web:58ad5040db096fbe071742'),
    messagingSenderId: _getEnvVar('FIREBASE_MESSAGING_SENDER_ID', '843407503335'),
    projectId: _getEnvVar('FIREBASE_PROJECT_ID', 'takatsu-projects'),
    authDomain: _getEnvVar('FIREBASE_AUTH_DOMAIN', 'takatsu-projects.firebaseapp.com'),
    storageBucket: _getEnvVar('FIREBASE_STORAGE_BUCKET', 'takatsu-projects.firebasestorage.app'),
    measurementId: _getEnvVar('FIREBASE_MEASUREMENT_ID', 'G-FWR3B90F6M'),
  );
}
