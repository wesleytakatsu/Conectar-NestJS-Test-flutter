import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:conectar_app/services/auth_service.dart';
import 'package:conectar_app/services/google_auth_service.dart';

// Generate mocks with:
// dart run build_runner build

@GenerateMocks([
  Dio,
  FlutterSecureStorage,
  GoogleSignIn,
  GoogleSignInAccount,
  GoogleSignInAuthentication,
  AuthService,
  GoogleAuthService,
])
void main() {
  // This file is used to generate mocks
  // Run: dart run build_runner build
}