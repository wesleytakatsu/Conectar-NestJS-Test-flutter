import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';
import '../config/app_config.dart';

class UsersService {
  late final Dio _dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  UsersService() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConfig.apiUrl,
      connectTimeout: Duration(seconds: AppConfig.connectionTimeout),
      receiveTimeout: Duration(seconds: AppConfig.receiveTimeout),
    ));
    
    if (AppConfig.debugLogs) {
      debugPrint('UsersService configurado para: ${AppConfig.apiUrl}');
    }

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? token = await _storage.read(key: 'token');
        options.headers['Authorization'] = 'Bearer $token';
              return handler.next(options);
      },
    ));
  }

  Future<List<User>> fetchUsers({String? role, String? name}) async {
    try {
      final response = await _dio.get('/users', queryParameters: {
        if (role != null) 'role': role,
        if (name != null) 'name': name,
      });
      return (response.data as List).map((json) => User.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch users');
    }
  }

  Future<User?> getUserById(String id) async {
    try {
      final response = await _dio.get('/users/$id');
      return User.fromJson(response.data);
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 404) {
        return null;
      }
      throw Exception('Failed to fetch user');
    }
  }

  Future<User> createUser(User user) async {
    try {
      final response = await _dio.post('/users', data: user.toJson());
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create user');
    }
  }

  Future<User> updateUser(String id, User user) async {
    try {
      final response = await _dio.patch('/users/$id', data: user.toJson());
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _dio.delete('/users/$id');
    } catch (e) {
      throw Exception('Failed to delete user');
    }
  }

  Future<User> getProfile() async {
    try {
      final response = await _dio.get('/users/profile');
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get profile');
    }
  }

  Future<User> updateProfile(Map<String, dynamic> profileData) async {
    try {
      final response = await _dio.patch('/users/profile', data: profileData);
      return User.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        throw Exception('Failed to update profile: ${e.response?.data?['message'] ?? e.message}');
      }
      throw Exception('Failed to update profile');
    }
  }
}