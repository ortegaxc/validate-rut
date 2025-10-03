import 'package:validate_rut/validate_rut.dart';

void main() {
  print('🇨🇱 Chilean RUT Validation Examples\n');

  // Example RUTs for testing
  List<String> testRuts = [
    '12.345.678-5',
    '98765432-1',
    '11111111-1',
    '5.544.332-7',
    '16977837-K',
    '123456789', // Invalid
    '12.345.678-9', // Invalid check digit
    '',
    'abc-def',
  ];

  print('=== Using ValidateRut Class (Recommended) ===\n');

  for (String rut in testRuts) {
    print('Testing RUT: "$rut"');

    // Validate using the class
    bool isValid = ValidateRut.validate(rut);
    print('  ✓ Valid: $isValid');

    if (rut.isNotEmpty && ValidateRut.hasValidFormat(rut)) {
      // Format the RUT
      String formatted = ValidateRut.format(rut);
      print('  📄 Formatted: $formatted');

      // Clean the RUT
      String cleaned = ValidateRut.clean(rut);
      print('  🧹 Cleaned: $cleaned');

      // Try to calculate check digit if we have enough digits
      try {
        if (cleaned.isNotEmpty && cleaned.length >= 7) {
          String numberPart = cleaned.substring(0, cleaned.length - 1);
          if (RegExp(r'^\d+$').hasMatch(numberPart)) {
            String calculatedDv = ValidateRut.calculateCheckDigit(numberPart);
            print('  🔢 Calculated check digit: $calculatedDv');
          }
        }
      } catch (e) {
        print('  ⚠️  Cannot calculate check digit: ${e.toString()}');
      }
    }

    print('');
  }

  print('=== Generating Complete RUTs ===\n');

  List<String> baseNumbers = ['12345678', '98765432', '16977837'];

  for (String baseNumber in baseNumbers) {
    print('Base number: $baseNumber');
    try {
      String completeRut = ValidateRut.generateComplete(baseNumber);
      print('  🎯 Complete RUT: $completeRut');
      print('  ✓ Valid: ${ValidateRut.validate(completeRut)}');
    } catch (e) {
      print('  ❌ Error: $e');
    }
    print('');
  }

  print('=== Backwards Compatibility (Individual Functions) ===\n');

  String testRut = '12.345.678-5';
  print('Using individual functions with "$testRut":');
  print('  validateRut(): ${validateRut(testRut)}');
  print('  formatRut(): ${formatRut(testRut)}');
  print('  removeRutFormatting(): ${removeRutFormatting(testRut)}');

  print('\n🎉 All examples completed!');
  print('\n💡 Recommendation: Use ValidateRut.method() for cleaner code!');
}
