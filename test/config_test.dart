import 'package:flutter_test/flutter_test.dart';
import 'package:conectar_app/config/app_config.dart';

void main() {
  test('Verificar configuração da API com porta 3010', () async {
    // Inicializar configuração
    await AppConfig.initialize();
    
    // Verificar se a URL contém a porta 3010
    expect(AppConfig.apiUrl.contains('3010'), true);
    
    // Imprimir para verificação visual
    print('URL da API configurada: ${AppConfig.apiUrl}');
    
    // Verificar URLs específicas por plataforma
    expect(AppConfig.apiUrl.contains('localhost:3010') || 
           AppConfig.apiUrl.contains('192.168.1.30:3010'), true);
  });
}