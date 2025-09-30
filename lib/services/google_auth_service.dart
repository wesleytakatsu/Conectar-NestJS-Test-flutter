import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );
  late final FirebaseAuth? _firebaseAuth;

  GoogleAuthService() {
    // Verificar se o Firebase foi inicializado antes de usar
    try {
      _firebaseAuth = Firebase.apps.isNotEmpty ? FirebaseAuth.instance : null;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Firebase não inicializado, Google Sign-In pode não funcionar: $e');
      }
      _firebaseAuth = null;
    }
  }

  /// Realiza o login com Google (método simplificado para desenvolvimento)
  Future<GoogleSignInAccount?> signInWithGoogleSimple() async {
    try {
      debugPrint('Iniciando Google Sign-In (modo simplificado)...');
      
      // Para web, usar signInSilently primeiro (método recomendado)
      if (kIsWeb) {
        debugPrint('Detectada plataforma Web - usando método otimizado');
        try {
          // Tentar login silencioso primeiro
          final GoogleSignInAccount? silentUser = await _googleSignIn.signInSilently();
          if (silentUser != null) {
            debugPrint('Login silencioso realizado com sucesso!');
            return silentUser;
          }
        } catch (e) {
          debugPrint('Login silencioso não disponível: $e');
        }
        
        // Se o login silencioso falhar, usar o método regular mas sem acessar People API
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        
        if (googleUser == null) {
          debugPrint('Usuário cancelou o login');
          return null;
        }

        debugPrint('Google Sign-In realizado com sucesso!');
        debugPrint('Email: ${googleUser.email}');
        debugPrint('Nome: ${googleUser.displayName}');
        
        return googleUser;
      } else {
        // Para outras plataformas, usar o método normal
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        
        if (googleUser == null) {
          return null;
        }
        
        return googleUser;
      }
    } catch (e) {
      // Se for erro da People API, tentar abordagem alternativa
      if (e.toString().contains('People API') || e.toString().contains('SERVICE_DISABLED')) {
        // Retornar null para que o AuthController tente a próxima abordagem
        return null;
      }
      
      throw Exception('Falha ao realizar login com Google: $e');
    }
  }

  /// Realiza o login com Google usando Firebase Authentication
  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      // Verificar se Firebase está disponível
      if (_firebaseAuth == null) {
        throw Exception('Firebase não está inicializado. Google Sign-In não está disponível nesta plataforma.');
      }

      // Iniciar o fluxo de login do Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        // Usuário cancelou o login
        return null;
      }

      // Obter os detalhes de autenticação da requisição
      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;

      // Criar uma nova credencial
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Fazer login no Firebase com a credencial
      final UserCredential userCredential = 
          await _firebaseAuth.signInWithCredential(credential);

      // Verificar se o login foi bem-sucedido
      if (userCredential.user != null) {
        return googleUser;
      }

      return null;
    } catch (e) {
      throw Exception('Falha ao realizar login com Google: $e');
    }
  }

  /// Obter informações do usuário atual do Google
  GoogleSignInAccount? getCurrentUser() {
    return _googleSignIn.currentUser;
  }

  /// Verificar se o usuário está logado no Google
  bool isSignedIn() {
    return _googleSignIn.currentUser != null;
  }

  /// Fazer logout do Google
  Future<void> signOut() async {
    try {
      await Future.wait([
        _googleSignIn.signOut(),
        if (_firebaseAuth != null) _firebaseAuth.signOut(),
      ]);
    } catch (e) {
      throw Exception('Falha ao fazer logout do Google: $e');
    }
  }

  /// Desconectar completamente do Google (revogar acesso)
  Future<void> disconnect() async {
    try {
      await _googleSignIn.disconnect();
      if (_firebaseAuth != null) {
        await _firebaseAuth.signOut();
      }
    } catch (e) {
      throw Exception('Falha ao desconectar do Google: $e');
    }
  }

  /// Obter o token de acesso do Firebase para usar na API
  Future<String?> getFirebaseIdToken() async {
    try {
      if (_firebaseAuth == null) {
        return null;
      }
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        return await user.getIdToken();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Método específico para Web que obtém dados do token JWT sem usar People API
  Future<Map<String, dynamic>?> signInWithGoogleWeb() async {
    if (!kIsWeb) return null;
    
    try {
      // Obter o token de autenticação diretamente
      final GoogleSignInAccount? googleUser = await _googleSignIn.signInSilently() ?? 
          await _googleSignIn.signIn();
      
      if (googleUser == null) {
        return null;
      }

      // Obter o token de autenticação
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      
      if (googleAuth.idToken != null) {
        // Decodificar o token JWT para obter informações do usuário
        final tokenData = _decodeJWT(googleAuth.idToken!);
        
        return {
          'email': googleUser.email,
          'name': googleUser.displayName ?? tokenData['name'] ?? 'Usuário',
          'googleId': googleUser.id,
          'photoURL': googleUser.photoUrl ?? tokenData['picture'],
          'idToken': googleAuth.idToken,
          'accessToken': googleAuth.accessToken,
        };
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Decodifica um token JWT para extrair informações (sem validação de assinatura)
  Map<String, dynamic> _decodeJWT(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Token JWT inválido');
    }
    
    final payload = parts[1];
    final normalized = base64.normalize(payload);
    final decoded = utf8.decode(base64.decode(normalized));
    return json.decode(decoded);
  }
}