import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/auth_service.dart';
import '../services/google_auth_service.dart';
import '../models/user.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final GoogleAuthService _googleAuthService = GoogleAuthService();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  bool _isLoggedIn = false;
  bool _isGoogleLoading = false;
  User? _currentUser;

  bool get isLoggedIn => _isLoggedIn;
  bool get isGoogleLoading => _isGoogleLoading;
  User? get currentUser => _currentUser;
  AuthService get authService => _authService;

  AuthController() {
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    try {
      String? token = await _storage.read(key: 'token');
      if (token != null && token.isNotEmpty) {
        // Token existe, tentar buscar o perfil do usuário para validar
        try {
          var profile = await _authService.getProfile();
          _currentUser = User.fromJson(profile);
          _isLoggedIn = true;
          notifyListeners();
        } catch (e) {
          // Token inválido ou expirado, remover e marcar como deslogado
          await _storage.delete(key: 'token');
          _isLoggedIn = false;
          _currentUser = null;
          notifyListeners();
        }
      } else {
        _isLoggedIn = false;
        notifyListeners();
      }
    } catch (e) {
      // Se houver erro na leitura, considerar como não logado
      _isLoggedIn = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      var response = await _authService.login(email, password);
      
      // Armazenar o token JWT no flutter_secure_storage
      await _storage.write(key: 'token', value: response['access_token']);
      
      // Atualizar o estado do usuário
      _currentUser = User.fromJson(response['user']);
      _isLoggedIn = true;
      notifyListeners();
      
      // O GoRouter irá automaticamente redirecionar para /home baseado no estado isLoggedIn
    } catch (e) {
      // Aqui você pode adicionar um snackbar ou outro método de notificação se necessário
      rethrow;
    }
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    try {
      var response = await _authService.register(name, email, password, 'user');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      // Fazer logout do Google se estiver logado
      if (_googleAuthService.isSignedIn()) {
        await _googleAuthService.signOut();
      }
      
      // Remover o token do armazenamento seguro
      await _storage.delete(key: 'token');
      
      // Limpar o estado
      _isLoggedIn = false;
      _currentUser = null;
      notifyListeners();
      
      // O GoRouter irá automaticamente redirecionar para /login baseado no estado isLoggedIn
    } catch (e) {
      // Mesmo se houver erro, ainda limpar o estado
      _isLoggedIn = false;
      _currentUser = null;
      notifyListeners();
    }
  }

  /// Login com Google
  Future<void> signInWithGoogle() async {
    _isGoogleLoading = true;
    notifyListeners();
    
    try {
      // Para Web, usar método otimizado que não usa People API
      if (kIsWeb) {
        final googleData = await _googleAuthService.signInWithGoogleWeb();
        
        if (googleData != null) {
          // Enviar dados para o backend para login/registro
          final response = await _authService.googleAuth(
            idToken: googleData['idToken'],
            email: googleData['email'],
            name: googleData['name'],
            googleId: googleData['googleId'],
            photoURL: googleData['photoURL'],
          );
          
          // Armazenar o token JWT recebido do backend
          await _storage.write(key: 'token', value: response['access_token']);
          
          // Atualizar o estado do usuário com os dados do backend
          _currentUser = User.fromJson(response['user']);
          _isLoggedIn = true;
          notifyListeners();
          return;
        }
      }
      
      // Primeiro tentar o método simplificado (sem Firebase)
      final GoogleSignInAccount? googleUser = await _googleAuthService.signInWithGoogleSimple();
      
      if (googleUser != null) {
        // Para desenvolvimento, vamos simular um token
        final simulatedToken = 'dev_token_${DateTime.now().millisecondsSinceEpoch}';
        
        // Enviar dados para o backend para login/registro
        final response = await _authService.googleAuth(
          idToken: simulatedToken, // Token simulado para desenvolvimento
          email: googleUser.email,
          name: googleUser.displayName ?? 'Usuário',
          googleId: googleUser.id,
          photoURL: googleUser.photoUrl,
        );
        
        // Armazenar o token JWT recebido do backend
        await _storage.write(key: 'token', value: response['access_token']);
        
        // Atualizar o estado do usuário com os dados do backend
        _currentUser = User.fromJson(response['user']);
        _isLoggedIn = true;
        notifyListeners();
        return;
      }
      
      // Se o método simplificado falhar, tentar o método com Firebase
      final GoogleSignInAccount? googleUserFirebase = await _googleAuthService.signInWithGoogle();
      
      if (googleUserFirebase != null) {
        // Obter o token do Firebase para enviar para o backend
        final String? idToken = await _googleAuthService.getFirebaseIdToken();
        
        if (idToken != null) {
          // Enviar dados para o backend para login/registro
          final response = await _authService.googleAuth(
            idToken: idToken,
            email: googleUserFirebase.email,
            name: googleUserFirebase.displayName ?? 'Usuário',
            googleId: googleUserFirebase.id,
            photoURL: googleUserFirebase.photoUrl,
          );
          
          // Armazenar o token JWT recebido do backend
          await _storage.write(key: 'token', value: response['access_token']);
          
          // Atualizar o estado do usuário com os dados do backend
          _currentUser = User.fromJson(response['user']);
          _isLoggedIn = true;
          notifyListeners();
        } else {
          throw Exception('Não foi possível obter o token de autenticação do Firebase');
        }
      }
    } catch (e) {
      // Re-throw do erro para que possa ser tratado na UI
      rethrow;
    } finally {
      _isGoogleLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile(Map<String, dynamic> profileData) async {
    try {
      final response = await _authService.updateProfile(profileData);
      _currentUser = User.fromJson(response);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}