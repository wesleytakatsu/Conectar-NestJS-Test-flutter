import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/users_service.dart';

class UsersController extends ChangeNotifier {
  final UsersService _usersService = UsersService();
  List<User> _users = [];
  bool _isLoading = false;

  List<User> get users => _users;
  bool get isLoading => _isLoading;

  UsersController() {
    fetchUsers();
  }

  Future<void> fetchUsers({String? role, String? name}) async {
    _isLoading = true;
    notifyListeners();
    try {
      var fetchedUsers = await _usersService.fetchUsers(role: role, name: name);
      _users = fetchedUsers;
    } catch (e) {
      debugPrint('Erro ao buscar usuários: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<User?> getUserById(String id) async {
    try {
      return await _usersService.getUserById(id);
    } catch (e) {
      debugPrint('Erro ao buscar usuário por ID: $e');
      return null;
    }
  }

  Future<void> createUser(User user) async {
    try {
      await _usersService.createUser(user);
      fetchUsers();
    } catch (e) {
      debugPrint('Erro ao criar usuário: $e');
    }
  }

  Future<void> updateUser(String id, User user) async {
    try {
      await _usersService.updateUser(id, user);
      fetchUsers();
    } catch (e) {
      debugPrint('Erro ao atualizar usuário: $e');
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _usersService.deleteUser(id);
      fetchUsers();
    } catch (e) {
      debugPrint('Erro ao deletar usuário: $e');
    }
  }
}