import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;
  final String? hintText;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.items,
    this.value,
    required this.onChanged,
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
        
        DropdownButtonFormField<String>(
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          decoration: InputDecoration(
            hintText: hintText ?? 'Selecione',
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
          initialValue: value,
          hint: Text(
            hintText ?? 'Selecione',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}