import 'remove_rut_formatting.dart';

String formatRut(String rut) {
  final unformattedRut = removeRutFormatting(rut);

  String formattedNumber = '';
  for (int i = unformattedRut.length - 1, j = 1; i >= 0; i--, j++) {
    formattedNumber = unformattedRut[i] + formattedNumber;
    if (j % 3 == 0 && i > 0) {
      formattedNumber = '.$formattedNumber';
    }
  }

  final checkDigit = unformattedRut[unformattedRut.length - 1];
  return '$formattedNumber-$checkDigit';
}
