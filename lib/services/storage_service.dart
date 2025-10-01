import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    if (_shouldUseSharedPreferences()) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  static bool _shouldUseSharedPreferences() {
    // Use SharedPreferences no macOS para evitar problemas de entitlements durante desenvolvimento
    return !kIsWeb && Platform.isMacOS;
  }

  static Future<String?> read({required String key}) async {
    if (_shouldUseSharedPreferences()) {
      await _ensurePrefsInitialized();
      return _prefs?.getString(key);
    } else {
      return await _secureStorage.read(key: key);
    }
  }

  static Future<void> write({required String key, required String? value}) async {
    if (_shouldUseSharedPreferences()) {
      await _ensurePrefsInitialized();
      if (value != null) {
        await _prefs?.setString(key, value);
      } else {
        await _prefs?.remove(key);
      }
    } else {
      await _secureStorage.write(key: key, value: value);
    }
  }

  static Future<void> delete({required String key}) async {
    if (_shouldUseSharedPreferences()) {
      await _ensurePrefsInitialized();
      await _prefs?.remove(key);
    } else {
      await _secureStorage.delete(key: key);
    }
  }

  static Future<void> deleteAll() async {
    if (_shouldUseSharedPreferences()) {
      await _ensurePrefsInitialized();
      await _prefs?.clear();
    } else {
      await _secureStorage.deleteAll();
    }
  }

  static Future<void> _ensurePrefsInitialized() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }
}
