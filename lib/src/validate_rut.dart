import 'calculate_dv.dart';
import 'remove_rut_formatting.dart';

bool validateRut(String rut) {
  final unformattedRut = removeRutFormatting(rut);

  // The RUT is not the proper length
  if (unformattedRut.length != 9) return false;

  final parts = unformattedRut.split('');
  final checkDigit = parts.removeLast();
  final number = parts.join('');

  final dvCalculado = calculateDv(number);

  return checkDigit.toUpperCase() == dvCalculado;
}
