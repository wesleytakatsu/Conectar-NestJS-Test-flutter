import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isFullWidth;
  final EdgeInsets padding;
  final bool isLoading;

  const GoogleSignInButton({
    super.key,
    required this.onPressed,
    this.isFullWidth = false,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.grey[600]!,
                  ),
                ),
              )
            : Image.asset(
                'assets/images/google_logo.png',
                width: 20,
                height: 20,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.g_mobiledata,
                    color: Colors.grey[600],
                    size: 24,
                  );
                },
              ),
        label: Text(
          isLoading ? 'Entrando...' : 'Continuar com Google',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey[700],
          padding: padding,
          elevation: 1,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: Colors.grey[300]!,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}