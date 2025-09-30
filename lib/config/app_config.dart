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
        await dotenv.load(fileName: ".env");
        _initializeFromEnv();
      }
    } catch (e) {
      // Usar configurações padrão em caso de erro
      _initializeDefaults();
    }
  }

  static void _initializeWebConfig() {
    apiUrl = 'http://localhost:3000';
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
    apiUrl = 'http://localhost:3000';
    connectionTimeout = 10;
    receiveTimeout = 10;
    debugLogs = true;
  }

  static String _getApiUrl() {
    // Web - usar configuração hardcoded
    if (kIsWeb) {
      return 'http://localhost:3000';
    }
    
    // Android
    if (Platform.isAndroid) {
      return dotenv.env['API_URL_ANDROID'] ?? 'http://192.168.1.30:3000';
    }
    
    // iOS
    if (Platform.isIOS) {
      return dotenv.env['API_URL_IOS'] ?? 'http://localhost:3000';
    }
    
    // Desktop (Windows, macOS, Linux)
    return dotenv.env['API_URL'] ?? 'http://localhost:3000';
  }
}