import 'package:flutter/material.dart';

class ConectarLogo extends StatelessWidget {
  const ConectarLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      height: 74,
      child: ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        child: Image.asset(
          'assets/images/logo_menu.png',
          fit: BoxFit.cover, // Mantém as proporções
        ),
      ),
    );
  }
}