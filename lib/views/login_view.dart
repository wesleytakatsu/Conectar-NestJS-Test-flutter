import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../widgets/widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF16A085),
      body: Center(
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double formWidth = constraints.maxWidth > 800 
                  ? 600 
                  : constraints.maxWidth * 0.9;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 50.0),
                    child: ConectarLogo(),
                  ),
                  LoginCard(
                    maxWidth: formWidth,
                    onLogin: (email, password) {
                      context.read<AuthController>().login(email, password);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}