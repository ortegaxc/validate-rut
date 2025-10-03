import 'package:test/test.dart';
import 'package:validate_rut/validate_rut.dart';

void main() {
  group('formatRut', () {
    const testCases = [
      ['55443327', '5.544.332-7'],
      ['12345678', '1.234.567-8'],
      ['98765432', '9.876.543-2'],
      // Edge cases
      ['', ''],
      [' ', ''],
      ['-', ''],
      ['.', ''],
      ['.-', ''],
    ];

    for (final testCase in testCases) {
      final rut = testCase[0];
      final expected = testCase[1];

      test('formats $rut to $expected', () {
        expect(formatRut(rut), expected);
      });
    }
  });

  group('calculateDv', () {
    const testCases = [
      ['5544332', '7'],
      ['16977837', 'K']
    ];

    for (final testCase in testCases) {
      final rut = testCase[0];
      final expectedDv = testCase[1];

      test('calculates check digit for $rut as $expectedDv', () {
        expect(calculateDv(rut), expectedDv);
      });
    }

    // Test error cases
    test('throws ArgumentError for empty string', () {
      expect(() => calculateDv(''), throwsArgumentError);
    });

    test('throws ArgumentError for non-numeric string', () {
      expect(() => calculateDv('abc'), throwsArgumentError);
    });
  });

  group('validateRut', () {
    const testCases = [
      ['5544332-7', true, 'valid RUT without dots'],
      ['5.544.332-7', true, 'valid RUT with dots'],
      ['5544332-9', false, 'invalid RUT'],
      ['16977837-K', true, 'valid RUT with check digit "K"'],
      ['16977837-k', true, 'valid RUT with check digit "k" in lower case'],
      ['16977831-1', false, 'invalid RUT with incorrect check digit'],
      // Edge cases for empty/invalid inputs
      ['', false, 'empty string'],
      ['   ', false, 'whitespace only'],
      ['-', false, 'only dash'],
      ['.', false, 'only dot'],
      ['.-', false, 'only formatting characters'],
      ['1234567', false, 'too short (7 digits)'],
      ['1234567890', false, 'too long (10 digits)'],
      [' 5.544.332-7 ', true, 'valid RUT with surrounding spaces'],
    ];

    for (final testCase in testCases) {
      final rut = testCase[0] as String;
      final isValid = testCase[1] as bool;
      final description = testCase[2] as String;

      test('Should return $isValid for $description', () {
        expect(validateRut(rut), isValid);
      });
    }
  });

  group('removeRutFormatting', () {
    const testCases = [
      ['11.111.111-9', '111111119'],
      [' 5.544.332-7 ', '55443327'],
      ['', ''],
      ['   ', ''],
      ['-', ''],
      ['.', ''],
      ['.-', ''],
    ];

    for (final testCase in testCases) {
      final rut = testCase[0];
      final expected = testCase[1];

      test('removes formatting from $rut to be $expected', () {
        expect(removeRutFormatting(rut), expected);
      });
    }
  });
}
