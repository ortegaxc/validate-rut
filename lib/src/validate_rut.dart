import 'calculate_dv.dart';
import 'remove_rut_formatting.dart';

bool validateRut(String rut) {
  final unformattedRut = removeRutFormatting(rut);

// The RUT must be 8 or 9 characters long
  if (unformattedRut.length < 8 || unformattedRut.length > 9) return false;

  final parts = unformattedRut.split('');
  final checkDigit = parts.removeLast();
  final number = parts.join('');

  final dvCalculado = calculateDv(number);

  return checkDigit.toUpperCase() == dvCalculado;
}
