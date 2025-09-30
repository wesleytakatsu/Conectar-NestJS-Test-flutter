import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../controllers/auth_controller.dart';
import '../widgets/widgets.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  bool _isLoading = false;

  void _showSnackBar(String message, {bool isError = false}) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red : Colors.green,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  Future<void> _handleRegister(String name, String email, String password) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final authController = context.read<AuthController>();
      await authController.register(name, email, password);
      
      _showSnackBar('Conta criada com sucesso! Faça login para continuar.');
      
      await Future.delayed(const Duration(milliseconds: 1500));
      
      if (mounted) {
        context.go('/login');
      }
    } catch (e) {
      String errorMessage = 'Erro ao criar conta. Tente novamente.';
      
      final errorString = e.toString().toLowerCase();
      if (errorString.contains('email')) {
        if (errorString.contains('already') || errorString.contains('exists') || errorString.contains('já')) {
          errorMessage = 'Este email já está cadastrado. Tente fazer login ou use outro email.';
        } else {
          errorMessage = 'Email inválido. Verifique o formato do email.';
        }
      } else if (errorString.contains('password') || errorString.contains('senha')) {
        errorMessage = 'Senha deve ter pelo menos 6 caracteres.';
      } else if (errorString.contains('name') || errorString.contains('nome')) {
        errorMessage = 'Nome é obrigatório.';
      } else if (errorString.contains('network') || errorString.contains('connection')) {
        errorMessage = 'Erro de conexão. Verifique sua internet e tente novamente.';
      } else if (errorString.contains('validation') || errorString.contains('invalid')) {
        errorMessage = 'Dados inválidos. Verifique os campos e tente novamente.';
      }
      
      _showSnackBar(errorMessage, isError: true);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF16A085),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double formWidth = constraints.maxWidth > 800 
                      ? 600 
                      : constraints.maxWidth * 0.9;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: ConectarLogo(),
                      ),
                      RegisterCard(
                        maxWidth: formWidth,
                        onRegister: _handleRegister,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF16A085)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}