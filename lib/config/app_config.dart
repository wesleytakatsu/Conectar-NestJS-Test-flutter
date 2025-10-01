import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class AppConfig {
  static late String apiUrl;
  static late int connectionTimeout;
  static late int receiveTimeout;
  static late bool debugLogs;

  static Future<void> initialize() async {
    try {
      // Para web, usar configurações hardcoded temporariamente
      if (kIsWeb) {
        _initializeWebConfig();
      } else {
        // Para outras plataformas, usar .env
        await dotenv.load();
        _initializeFromEnv();
      }
    } catch (e) {
      // Usar configurações padrão em caso de erro
      _initializeDefaults();
    }
  }

  static void _initializeWebConfig() {
    apiUrl = 'https://discussing-around-attorney-prototype.trycloudflare.com';
    connectionTimeout = 10;
    receiveTimeout = 10;
    debugLogs = true;
  }

  static void _initializeFromEnv() {
    apiUrl = _getApiUrl();
    connectionTimeout = int.parse(dotenv.env['CONNECTION_TIMEOUT'] ?? '10');
    receiveTimeout = int.parse(dotenv.env['RECEIVE_TIMEOUT'] ?? '10');
    debugLogs = dotenv.env['DEBUG_LOGS']?.toLowerCase() == 'true';
  }

  static void _initializeDefaults() {
    apiUrl = 'https://discussing-around-attorney-prototype.trycloudflare.com';
    connectionTimeout = 10;
    receiveTimeout = 10;
    debugLogs = true;
  }

  static String _getApiUrl() {
    // Web - usar configuração hardcoded
    if (kIsWeb) {
      return 'https://discussing-around-attorney-prototype.trycloudflare.com';
    }
    
    // Android
    if (Platform.isAndroid) {
      return dotenv.env['API_URL_ANDROID'] ?? 'https://discussing-around-attorney-prototype.trycloudflare.com';
    }
    
    // iOS
    if (Platform.isIOS) {
      return dotenv.env['API_URL_IOS'] ?? 'https://discussing-around-attorney-prototype.trycloudflare.com';
    }
    
    // Desktop (Windows, macOS, Linux)
    return dotenv.env['API_URL'] ?? 'https://discussing-around-attorney-prototype.trycloudflare.com';
  }
}