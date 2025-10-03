// Example using ValidateRut class (new recommended API)
import 'package:validate_rut/src/validate_rut_class.dart';
import 'package:validate_rut/src/calculate_dv.dart';
import 'package:validate_rut/src/format_rut.dart';
import 'package:validate_rut/src/remove_rut_formatting.dart';
import 'package:validate_rut/src/validate_rut.dart';

void main() {
  print('=== RUT Validator Examples ===\n');

  // Example RUTs for testing (using real valid Chilean RUTs)
  List<String> testRuts = [
    '11111111-1',
    '22222222-2',
    '11.111.111-1',
    '24965885-K', // Valid RUT with K check digit
    '1-9',
    '123456789', // Invalid - missing check digit
    '11111111-2', // Invalid - wrong check digit
    '', // Empty string
    'abc', // Invalid format
  ];

  // Test using the new ValidateRut class (recommended)
  print('--- Using ValidateRut class (recommended) ---');
  for (String rut in testRuts) {
    print('\nTesting RUT: "$rut"');

    try {
      bool isValid = ValidateRut.validate(rut);

      if (isValid) {
        String cleanRut = ValidateRut.clean(rut);
        String formattedRut = ValidateRut.format(cleanRut);
        String checkDigit = ValidateRut.calculateCheckDigit(cleanRut);

        print('  ✅ Valid RUT');
        print('  Clean: $cleanRut');
        print('  Formatted: $formattedRut');
        print('  Check digit: $checkDigit');
      } else {
        print('  ❌ Invalid RUT');
      }
    } catch (e) {
      print('  ❌ Error: $e');
    }
  }

  print('\n--- Using individual functions (backwards compatibility) ---');
  for (String rut in testRuts) {
    print('\nTesting RUT: "$rut"');

    try {
      bool isValid = validateRut(rut);

      if (isValid) {
        String cleanRut = removeRutFormatting(rut);
        String formattedRut = formatRut(cleanRut);
        String checkDigit = calculateDv(cleanRut);

        print('  ✅ Valid RUT');
        print('  Clean: $cleanRut');
        print('  Formatted: $formattedRut');
        print('  Check digit: $checkDigit');
      } else {
        print('  ❌ Invalid RUT');
      }
    } catch (e) {
      print('  ❌ Error: $e');
    }
  }

  print('\n=== Demo completed ===');
}
