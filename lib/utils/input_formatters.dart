import 'package:flutter/services.dart';

class CnpjInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length > 14) {
      text = text.substring(0, 14);
    }
    if (text.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }
    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 2 && text.length > 2) {
        formatted += '.';
      } else if (i == 5 && text.length > 5) {
        formatted += '.';
      } else if (i == 8 && text.length > 8) {
        formatted += '/';
      } else if (i == 12 && text.length > 12) {
        formatted += '-';
      }
      formatted += text[i];
    }
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class TelefoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length > 11) {
      text = text.substring(0, 11);
    }
    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 0) {
        formatted += '(';
      } else if (i == 2) {
        formatted += ') ';
      } else if (i == 7) {
        formatted += '-';
      }
      formatted += text[i];
    }
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class CepInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length > 8) {
      text = text.substring(0, 8);
    }
    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 5) {
        formatted += '-';
      }
      formatted += text[i];
    }
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class InputUtils {
  static String cleanCnpj(String cnpj) {
    return cnpj.replaceAll(RegExp(r'[^0-9]'), '');
  }

  static String cleanTelefone(String telefone) {
    return telefone.replaceAll(RegExp(r'[^0-9]'), '');
  }

  static String cleanCep(String cep) {
    return cep.replaceAll(RegExp(r'[^0-9]'), '');
  }

  static bool isValidCnpj(String cnpj) {
    String cleaned = cleanCnpj(cnpj);
    return cleaned.length == 14;
  }

  static bool isValidTelefone(String telefone) {
    String cleaned = cleanTelefone(telefone);
    return cleaned.length >= 10 && cleaned.length <= 11;
  }

  static bool isValidCep(String cep) {
    String cleaned = cleanCep(cep);
    return cleaned.length == 8;
  }
}