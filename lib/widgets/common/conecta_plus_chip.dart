import 'package:flutter/material.dart';

class ConectaPlusChip extends StatelessWidget {
  final String conectaPlus;

  const ConectaPlusChip({
    super.key,
    required this.conectaPlus,
  });

  @override
  Widget build(BuildContext context) {
    final isConnected = conectaPlus == 'Sim';
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isConnected
            ? const Color(0xFF16A085).withValues(alpha: 0.1)
            : Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        conectaPlus,
        style: TextStyle(
          color: isConnected
              ? const Color(0xFF16A085)
              : Colors.grey[600],
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}