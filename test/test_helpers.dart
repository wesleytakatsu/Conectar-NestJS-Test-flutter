import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:conectar_app/controllers/auth_controller.dart';
import 'package:conectar_app/models/user.dart';
import 'package:conectar_app/services/auth_service.dart';
import 'test_setup.dart';

/// Helpers e utilities comuns para testes
class TestHelpers {
  
  /// Cria um MaterialApp com providers necessários para testes
  static Widget createTestApp({
    required Widget child,
    AuthController? authController,
  }) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthController>(
            create: (_) => authController ?? MockAuthController(),
          ),
        ],
        child: child,
      ),
    );
  }

  /// Cria dados de usuário mock para testes
  static Map<String, dynamic> createMockUserData({
    String id = '1',
    String name = 'Test User',
    String email = 'test@example.com',
    String role = 'user',
    bool isGoogleUser = false,
  }) {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'createdAt': '2023-01-01T10:00:00.000Z',
      'updatedAt': '2023-01-01T10:00:00.000Z',
      'isGoogleUser': isGoogleUser,
    };
  }

  /// Cria dados de empresa mock para testes
  static Map<String, dynamic> createMockCompanyData({
    String id = '1',
    String razaoSocial = 'Empresa Teste Ltda',
    String? nomeFantasia = 'Empresa Teste',
    String cnpj = '12.345.678/0001-90',
    String status = 'ativo',
    bool conectaPlus = false,
  }) {
    return {
      'id': id,
      'razaoSocial': razaoSocial,
      'nomeFantasia': nomeFantasia,
      'cnpj': cnpj,
      'email': 'contato@empresateste.com',
      'telefone': '(11) 1234-5678',
      'endereco': 'Rua Teste, 123',
      'cidade': 'São Paulo',
      'estado': 'SP',
      'cep': '01234-567',
      'status': status,
      'conectaPlus': conectaPlus,
      'createdAt': '2023-01-01T10:00:00.000Z',
      'updatedAt': '2023-01-01T10:00:00.000Z',
    };
  }

  /// Simula delay de rede para testes assíncronos
  static Future<void> simulateNetworkDelay({
    Duration delay = const Duration(milliseconds: 100),
  }) async {
    await Future.delayed(delay);
  }

  /// Cria dados de resposta de login mock
  static Map<String, dynamic> createMockLoginResponse({
    String token = 'mock_access_token_123',
    Map<String, dynamic>? user,
  }) {
    return {
      'access_token': token,
      'user': user ?? createMockUserData(),
    };
  }

  /// Cria lista de usuários mock para testes
  static List<Map<String, dynamic>> createMockUsersList({
    int count = 3,
  }) {
    return List.generate(count, (index) => createMockUserData(
      id: (index + 1).toString(),
      name: 'User ${index + 1}',
      email: 'user${index + 1}@example.com',
      role: index == 0 ? 'admin' : 'user',
    ));
  }

  /// Cria lista de empresas mock para testes
  static List<Map<String, dynamic>> createMockCompaniesList({
    int count = 3,
  }) {
    return List.generate(count, (index) => createMockCompanyData(
      id: (index + 1).toString(),
      razaoSocial: 'Empresa ${index + 1} Ltda',
      cnpj: '12.345.678/000${index + 1}-90',
      status: index % 2 == 0 ? 'ativo' : 'inativo',
      conectaPlus: index % 3 == 0,
    ));
  }

  /// Valida estrutura de dados de usuário
  static void validateUserData(Map<String, dynamic> userData) {
    expect(userData.containsKey('id'), isTrue);
    expect(userData.containsKey('name'), isTrue);
    expect(userData.containsKey('email'), isTrue);
    expect(userData.containsKey('role'), isTrue);
    expect(userData['email'], contains('@'));
    expect(userData['role'], isIn(['user', 'admin']));
  }

  /// Valida estrutura de dados de empresa
  static void validateCompanyData(Map<String, dynamic> companyData) {
    expect(companyData.containsKey('id'), isTrue);
    expect(companyData.containsKey('razaoSocial'), isTrue);
    expect(companyData.containsKey('cnpj'), isTrue);
    expect(companyData.containsKey('status'), isTrue);
    expect(companyData.containsKey('conectaPlus'), isTrue);
    expect(companyData['status'], isIn(['ativo', 'inativo']));
    expect(companyData['conectaPlus'], isA<bool>());
  }

  /// Encontra widget por tipo com timeout
  static Future<Finder> findWidgetWithTimeout(
    WidgetTester tester,
    Type widgetType, {
    Duration timeout = const Duration(seconds: 5),
  }) async {
    final finder = find.byType(widgetType);
    await tester.pumpAndSettle(timeout);
    return finder;
  }

  /// Simula entrada de texto em campo
  static Future<void> enterTextInField(
    WidgetTester tester,
    Finder fieldFinder,
    String text,
  ) async {
    await tester.tap(fieldFinder);
    await tester.pumpAndSettle();
    await tester.enterText(fieldFinder, text);
    await tester.pumpAndSettle();
  }

  /// Simula tap em botão com aguardo
  static Future<void> tapButtonAndWait(
    WidgetTester tester,
    Finder buttonFinder,
  ) async {
    await tester.tap(buttonFinder);
    await tester.pump(); // Trigger the action
    await tester.pumpAndSettle(); // Wait for animations/state changes
  }

  /// Verifica se snackbar com mensagem específica é exibida
  static void expectSnackBarWithMessage(String message) {
    expect(
      find.descendant(
        of: find.byType(SnackBar),
        matching: find.text(message),
      ),
      findsOneWidget,
    );
  }

  /// Verifica se loading indicator está presente
  static void expectLoadingIndicator() {
    expect(
      find.byType(CircularProgressIndicator),
      findsOneWidget,
    );
  }

  /// Verifica se loading indicator não está presente
  static void expectNoLoadingIndicator() {
    expect(
      find.byType(CircularProgressIndicator),
      findsNothing,
    );
  }
}

/// Mock AuthController para testes
class MockAuthController extends ChangeNotifier implements AuthController {
  bool _isLoggedIn = false;
  bool _isGoogleLoading = false;
  Map<String, dynamic>? _currentUser;
  
  @override
  bool get isLoggedIn => _isLoggedIn;
  
  @override
  bool get isGoogleLoading => _isGoogleLoading;
  
  @override
  User? get currentUser => _currentUser != null ? User.fromJson(_currentUser!) : null;
  
  @override
  AuthService get authService {
    setupTestConfig();
    return AuthService();
  }

  void setLoggedIn(bool value, {Map<String, dynamic>? user}) {
    _isLoggedIn = value;
    _currentUser = user;
    notifyListeners();
  }

  void setGoogleLoading(bool value) {
    _isGoogleLoading = value;
    notifyListeners();
  }

  @override
  Future<void> login(String email, String password) async {
    await TestHelpers.simulateNetworkDelay();
    
    if (email == 'test@example.com' && password == 'password123') {
      setLoggedIn(true, user: TestHelpers.createMockUserData());
    } else {
      throw Exception('Invalid credentials');
    }
  }

  @override
  Future<void> checkLoginStatus() async {
    await TestHelpers.simulateNetworkDelay();
    // Simula verificação de token salvo
  }

  @override
  Future<void> logout() async {
    await TestHelpers.simulateNetworkDelay();
    setLoggedIn(false);
  }

  @override
  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    await TestHelpers.simulateNetworkDelay();
    
    if (email == 'existing@example.com') {
      throw Exception('Email already exists');
    }
    
    final userData = TestHelpers.createMockUserData(
      name: name,
      email: email,
    );
    return userData;
  }

  @override
  Future<void> signInWithGoogle() async {
    setGoogleLoading(true);
    await TestHelpers.simulateNetworkDelay(delay: const Duration(seconds: 2));
    
    // Simula sucesso do Google Sign In
    setLoggedIn(true, user: TestHelpers.createMockUserData(
      name: 'Google User',
      email: 'googleuser@gmail.com',
      isGoogleUser: true,
    ));
    setGoogleLoading(false);
  }

  @override
  Future<void> updateProfile(Map<String, dynamic> data) async {
    await TestHelpers.simulateNetworkDelay();
    
    if (_currentUser != null) {
      _currentUser = {..._currentUser!, ...data};
      notifyListeners();
    }
  }
}

/// Constantes para testes
class TestConstants {
  static const validEmail = 'test@example.com';
  static const validPassword = 'password123';
  static const adminEmail = 'admin@conectar.com';
  static const adminPassword = 'admin123';
  static const invalidEmail = 'invalid-email';
  static const weakPassword = '123';
  static const networkTimeout = Duration(seconds: 30);
  static const animationDuration = Duration(milliseconds: 300);
}