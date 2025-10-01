import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? hintText;

  const SearchTextField({
    super.key,
    required this.label,
    required this.controller,
    this.inputFormatters,
    this.keyboardType,
    this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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

        TextField(
          controller: controller,
          style: const TextStyle(fontSize: 16),
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,

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
        ),
      ],
    );
  }
}