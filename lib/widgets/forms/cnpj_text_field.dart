import 'package:flutter/material.dart';
import '../../utils/input_formatters.dart';

class CnpjTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final VoidCallback? onChanged;
  final bool isRequired;
  final bool isSearch;

  const CnpjTextField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.onChanged,
    this.isRequired = false,
    this.isSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sempre mostrar o label em cima para campos de busca
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 16),
          inputFormatters: [CnpjInputFormatter()],
          keyboardType: TextInputType.number,
          onChanged: onChanged != null ? (_) => onChanged!() : null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
          ),
          validator: validator,
        ),
      ],
    );
  }
}