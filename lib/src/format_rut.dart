import 'dart:math';

import 'remove_rut_formatting.dart';

String formatRut(String rut) {
  final unformattedRut = removeRutFormatting(rut)
      .substring(0, min(9, removeRutFormatting(rut).length));

  // Return empty or invalid input as-is
  if (unformattedRut.isEmpty) {
    return '';
  }

  // Separating check digit
  final checkDigit = unformattedRut[unformattedRut.length - 1];
  final numberWithoutCheckDigit =
      unformattedRut.substring(0, unformattedRut.length - 1);

  String formattedNumber = '';
  for (int i = numberWithoutCheckDigit.length - 1, j = 1; i >= 0; i--, j++) {
    formattedNumber = numberWithoutCheckDigit[i] + formattedNumber;
    if (j % 3 == 0 && i > 0) {
      formattedNumber = '.$formattedNumber';
    }
  }

  return '$formattedNumber-$checkDigit';
}
