import 'package:flutter/material.dart';
import '../forms/login_form.dart';

class LoginCard extends StatelessWidget {
  final Function(String email, String password) onLogin;
  final double maxWidth;

  const LoginCard({
    super.key,
    required this.onLogin,
    this.maxWidth = 400,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth,
      padding: const EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: LoginForm(onLogin: onLogin),
    );
  }
}