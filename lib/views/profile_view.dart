import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../widgets/widgets.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, authController, child) {
        final user = authController.currentUser;
        if (user == null) {
          return const Scaffold(
            backgroundColor: Color(0xFF16A085),
            body: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }
        
        return ConectarPageLayout(
          showBackButton: true,
          backRoute: '/home',
          child: ProfileCard(user: user),
        );
      },
    );
  }
}