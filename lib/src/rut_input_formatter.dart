import 'package:flutter/services.dart';
import '../validate_rut.dart';

class RutInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    String unformattedRut = removeRutFormatting(newValue.text);

    if (unformattedRut.isEmpty) {
      return TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    if (!rutVerificationDigitRegex.hasMatch(unformattedRut)) {
      return oldValue;
    }

    String formattedRut = formatRut(unformattedRut);

    return TextEditingValue(
      text: formattedRut,
      selection: TextSelection.collapsed(offset: formattedRut.length),
    );
  }
}
