import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../forms/custom_text_field.dart';
import '../buttons/primary_button.dart';

class RegisterForm extends StatefulWidget {
  final Function(String name, String email, String password) onRegister;

  const RegisterForm({
    super.key,
    required this.onRegister,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Criar Nova Conta',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2c2c2c),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          CustomTextField(
            label: 'Nome Completo',
            controller: nameController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira seu nome completo';
              }
              if (value.trim().length < 2) {
                return 'Nome deve ter pelo menos 2 caracteres';
              }
              return null;
            },
          ),
          const SizedBox(height: 25),
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
              if (value.length < 6) {
                return 'A senha deve ter pelo menos 6 caracteres';
              }
              return null;
            },
          ),
          const SizedBox(height: 25),
          CustomTextField(
            label: 'Confirmar Senha',
            hintText: '••••••••',
            controller: confirmPasswordController,
            obscureText: !_confirmPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey[600],
              ),
              onPressed: () {
                setState(() {
                  _confirmPasswordVisible = !_confirmPasswordVisible;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, confirme sua senha';
              }
              if (value != passwordController.text) {
                return 'As senhas não coincidem';
              }
              return null;
            },
          ),
          const SizedBox(height: 40),
          PrimaryButton(
            text: 'Criar Conta',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onRegister(
                  nameController.text.trim(),
                  emailController.text.trim(),
                  passwordController.text,
                );
              }
            },
            isFullWidth: true,
            padding: const EdgeInsets.symmetric(vertical: 18.0),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              context.go('/login');
            },
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                children: const [
                  TextSpan(text: 'Já tem uma conta? '),
                  TextSpan(
                    text: 'Faça login',
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

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}