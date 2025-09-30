import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../forms/custom_text_field.dart';
import '../buttons/primary_button.dart';
import '../buttons/google_sign_in_button.dart';
import '../../controllers/auth_controller.dart';

class LoginForm extends StatefulWidget {
  final Function(String email, String password) onLogin;

  const LoginForm({
    super.key,
    required this.onLogin,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    // Verifica se o login com Google está disponível nesta plataforma
    final bool isGoogleSignInEnabled = kIsWeb || Platform.isAndroid || Platform.isIOS || Platform.isMacOS;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            label: 'Email',
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira seu email';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Por favor, insira um email válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 25),
          CustomTextField(
            label: 'Senha',
            hintText: '••••••••',
            controller: passwordController,
            obscureText: !_passwordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey[600],
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira sua senha';
              }
              return null;
            },
          ),
          const SizedBox(height: 40),
          PrimaryButton(
            text: 'Entrar',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onLogin(emailController.text, passwordController.text);
              }
            },
            isFullWidth: true,
            padding: const EdgeInsets.symmetric(vertical: 18.0),
          ),
          const SizedBox(height: 20),
          // Divisor "OU"
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'OU',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Consumer<AuthController>(
            builder: (context, authController, child) {
              return Tooltip(
                message: isGoogleSignInEnabled 
                  ? '' 
                  : 'Login com Google só está disponível em Android, iOS, MacOS e no Navegador',
                child: GoogleSignInButton(
                  onPressed: isGoogleSignInEnabled && !authController.isGoogleLoading
                    ? () {
                        authController.signInWithGoogle();
                      }
                    : null,
                  isFullWidth: true,
                  isLoading: authController.isGoogleLoading,
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              context.go('/register');
            },
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                children: const [
                  TextSpan(text: 'Não tem uma conta? '),
                  TextSpan(
                    text: 'Registre-se',
                    style: TextStyle(
                      color: Color(0xFF16A085),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}