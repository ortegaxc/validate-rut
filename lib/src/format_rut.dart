import 'dart:math';

import 'remove_rut_formatting.dart';

String formatRut(String rut) {
  final cleanRut = removeRutFormatting(rut);

  if (cleanRut.isEmpty) {
    return '';
  }

  final unformattedRut = cleanRut.substring(0, min(9, cleanRut.length));

  if (unformattedRut.length < 2) {
    return unformattedRut;
  }

  final checkDigit = unformattedRut[unformattedRut.length - 1];
  final numberWithoutCheckDigit =
      unformattedRut.substring(0, unformattedRut.length - 1);

  if (numberWithoutCheckDigit.isEmpty) {
    return checkDigit;
  }

  String formattedNumber = '';
  for (int i = numberWithoutCheckDigit.length - 1, j = 1; i >= 0; i--, j++) {
    formattedNumber = numberWithoutCheckDigit[i] + formattedNumber;
    if (j % 3 == 0 && i > 0) {
      formattedNumber = '.$formattedNumber';
    }
  }

  return '$formattedNumber-$checkDigit';
}
