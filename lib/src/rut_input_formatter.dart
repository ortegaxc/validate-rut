import 'package:flutter/services.dart';
import '../validate_rut.dart';

class RutInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String unformattedRut = removeRutFormatting(newValue.text);

    // Handle empty input
    if (unformattedRut.isEmpty) {
      return TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    String formattedRut = formatRut(unformattedRut);

    if (!rutVerificationDigitRegex.hasMatch(unformattedRut)) return oldValue;

    return TextEditingValue(
      text: formattedRut,
      selection: TextSelection.collapsed(offset: formattedRut.length),
    );
  }
}
