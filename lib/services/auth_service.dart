import 'package:dio/dio.dart';
import '../config/app_config.dart';
import 'secure_storage_service.dart';

class AuthService {
  late final Dio _dio;
  final _storage = SecureStorageService.instance;

  Dio get dio => _dio;

  AuthService() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConfig.apiUrl,
      connectTimeout: Duration(seconds: AppConfig.connectionTimeout),
      receiveTimeout: Duration(seconds: AppConfig.receiveTimeout),
    ));
    
    // Interceptor para adicionar automaticamente o token JWT às requisições
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    ));
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      
      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw Exception('Login failed: ${e.response?.data?['message'] ?? e.message}');
      }
      throw Exception('Login failed: $e');
    }
  }

  Future<Map<String, dynamic>> register(String name, String email, String password, String role) async {
    try {
      final response = await _dio.post('/auth/register', data: {
        'name': name,
        'email': email,
        'password': password,
        'role': role,
      });
      return response.data;
    } catch (e) {
      throw Exception('Registration failed');
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await _dio.get('/users/profile');
      return response.data;
    } catch (e) {
      throw Exception('Failed to get profile');
    }
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> profileData) async {
    try {
      final response = await _dio.patch('/users/profile', data: profileData);
      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw Exception('Failed to update profile: ${e.response?.data?['message'] ?? e.message}');
      }
      throw Exception('Failed to update profile');
    }
  }

  Future<Map<String, dynamic>> googleAuth({
    required String idToken,
    required String email,
    required String name,
    required String googleId,
    String? photoURL,
  }) async {
    try {
      final requestData = {
        'idToken': idToken,
        'email': email,
        'name': name,
        'googleId': googleId,
        if (photoURL != null) 'photoURL': photoURL,
      };
      
      final response = await _dio.post('/auth/google', data: requestData);
      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw Exception('Google auth failed: ${e.response?.data?['message'] ?? e.message}');
      }
      throw Exception('Google auth failed: $e');
    }
  }
}