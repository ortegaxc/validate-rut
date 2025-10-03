import 'package:flutter/services.dart';
import '../validate_rut.dart';

/// A [TextInputFormatter] that formats Chilean RUT input as the user types.
///
/// This formatter will:
/// - Add dots and hyphen formatting (e.g., "12.345.678-9")
/// - Remove invalid characters
/// - Prevent input that doesn't match RUT pattern
///
/// Example usage:
/// ```dart
/// TextFormField(
///   inputFormatters: [RutInputFormatter()],
///   decoration: InputDecoration(
///     labelText: 'RUT',
///     hintText: '12.345.678-9',
///   ),
/// )
/// ```
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

    // Don't allow input that doesn't match basic RUT pattern
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
