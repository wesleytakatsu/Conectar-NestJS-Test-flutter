import 'package:flutter/material.dart';
import 'conectar_logo.dart';

class ConectarPageLayout extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final bool showBackButton;
  final String? backRoute;

  const ConectarPageLayout({
    super.key,
    required this.child,
    this.maxWidth = 600,
    this.showBackButton = false,
    this.backRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF16A085),
      body: Center(
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double cardWidth = constraints.maxWidth > 800 
                  ? (maxWidth ?? 600)
                  : constraints.maxWidth * 0.9;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: const ConectarLogo(),
                  ),
                  Container(
                    width: cardWidth,
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
                    child: child,
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