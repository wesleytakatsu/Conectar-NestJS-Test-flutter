import 'package:flutter/material.dart';
import '../forms/register_form.dart';

class RegisterCard extends StatelessWidget {
  final Function(String name, String email, String password) onRegister;
  final double maxWidth;

  const RegisterCard({
    super.key,
    required this.onRegister,
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
      child: RegisterForm(onRegister: onRegister),
    );
  }
}