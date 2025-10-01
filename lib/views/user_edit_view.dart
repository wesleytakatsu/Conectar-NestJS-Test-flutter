import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../controllers/users_controller.dart';
import '../models/user.dart';
import '../widgets/widgets.dart';

class UserEditView extends StatefulWidget {
  final String userId;
  
  const UserEditView({
    super.key,
    required this.userId,
  });

  @override
  UserEditViewState createState() => UserEditViewState();
}

class UserEditViewState extends State<UserEditView> {
  bool _isLoading = false;
  User? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final usersController = context.read<UsersController>();
      final user = await usersController.getUserById(widget.userId);
      
      if (user != null) {
        setState(() {
          _user = user;
        });
      } else {
        _showSnackBar('Usuário não encontrado.', isError: true);
        if (mounted) context.go('/users');
      }
    } catch (e) {
      _showSnackBar('Erro ao carregar usuário.', isError: true);
      if (mounted) context.go('/users');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : const Color(0xFF16A085),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF16A085),
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    if (_user == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF16A085),
        body: Center(
          child: Text(
            'Usuário não encontrado',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
    }
    
    return ConectarPageLayout(
      showBackButton: true,
      backRoute: '/users',
      child: UserEditForm(user: _user!),
    );
  }
}