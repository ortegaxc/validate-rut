import 'package:validate_rut/validate_rut.dart';

void main() {
  final rutList = ['55443327', '5.544.332-7', '5.544.332-8'];

  for (final rut in rutList) {
    if (!rut.contains('-')) {
      final formattedRut = formatRut(rut);
      print('The formatted RUT for $rut is $formattedRut.');

      final dv = calculateDv(rut.substring(0, rut.length - 1));
      print('The check digit for $rut is $dv.');
    }

    final isValid = validateRut(rut);
    print('The RUT $rut is ${isValid ? 'valid' : 'invalid'}.');

    final unformattedRut = removeRutFormatting(rut);
    print('The unformatted RUT for $rut is $unformattedRut.');
  }
}
