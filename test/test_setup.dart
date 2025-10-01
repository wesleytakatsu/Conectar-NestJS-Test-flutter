import 'package:conectar_app/config/app_config.dart';

/// Setup de configuração para testes
/// Este arquivo deve ser importado no início de cada teste
/// que precise do AppConfig configurado
void setupTestConfig() {
  // Configurar AppConfig para testes com valores mocados
  AppConfig.apiUrl = 'http://localhost:3010';
  AppConfig.connectionTimeout = 30;
  AppConfig.receiveTimeout = 30;
  AppConfig.debugLogs = false;
}

/// Setup de configuração para testes que simulam diferentes ambientes
class TestConfig {
  static void setupWithCustomValues({
    String? apiUrl,
    int? connectionTimeout,
    int? receiveTimeout,
    bool? debugLogs,
  }) {
    AppConfig.apiUrl = apiUrl ?? 'http://localhost:3010';
    AppConfig.connectionTimeout = connectionTimeout ?? 30;
    AppConfig.receiveTimeout = receiveTimeout ?? 30;
    AppConfig.debugLogs = debugLogs ?? false;
  }

  static void setupForIntegrationTests() {
    setupWithCustomValues(
      apiUrl: 'http://localhost:3010',
      connectionTimeout: 60,
      receiveTimeout: 60,
      debugLogs: true,
    );
  }
}