import 'package:test/test.dart';
import 'package:validate_rut/validate_rut.dart';

void main() {
  group('ValidateRut Class', () {
    group('validate', () {
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
          expect(ValidateRut.validate(rut), isValid);
        });
      }
    });

    group('format', () {
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
          expect(ValidateRut.format(rut), expected);
        });
      }
    });

    group('calculateCheckDigit', () {
      const testCases = [
        ['5544332', '7'],
        ['16977837', 'K']
      ];

      for (final testCase in testCases) {
        final rut = testCase[0];
        final expectedDv = testCase[1];

        test('calculates check digit for $rut as $expectedDv', () {
          expect(ValidateRut.calculateCheckDigit(rut), expectedDv);
        });
      }

      // Test error cases
      test('throws ArgumentError for empty string', () {
        expect(() => ValidateRut.calculateCheckDigit(''), throwsArgumentError);
      });

      test('throws ArgumentError for non-numeric string', () {
        expect(
            () => ValidateRut.calculateCheckDigit('abc'), throwsArgumentError);
      });
    });

    group('clean', () {
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
          expect(ValidateRut.clean(rut), expected);
        });
      }
    });

    group('hasValidFormat', () {
      const testCases = [
        ['12.345.678-9', true, 'properly formatted RUT'],
        ['123456789', true, 'unformatted RUT'],
        ['12345678K', true, 'RUT with K check digit'],
        ['1234567', false, 'too short'],
        ['1234567890', false, 'too long'],
        ['abc-def', false, 'non-numeric'],
        ['', false, 'empty string'],
      ];

      for (final testCase in testCases) {
        final rut = testCase[0] as String;
        final expected = testCase[1] as bool;
        final description = testCase[2] as String;

        test('$description should return $expected', () {
          expect(ValidateRut.hasValidFormat(rut), expected);
        });
      }
    });

    group('generateComplete', () {
      test('generates complete RUT with correct check digit', () {
        String completeRut = ValidateRut.generateComplete('5544332');
        expect(completeRut, '5.544.332-7');
        expect(ValidateRut.validate(completeRut), true);
      });
    });
  });

  // Backwards compatibility tests
  group('Individual Functions (Backwards Compatibility)', () {
    group('formatRut', () {
      test('formats 55443327 to 5.544.332-7', () {
        expect(formatRut('55443327'), '5.544.332-7');
      });

      test('formats empty string to empty string', () {
        expect(formatRut(''), '');
      });
    });

    group('calculateDv', () {
      test('calculates check digit for 5544332 as 7', () {
        expect(calculateDv('5544332'), '7');
      });

      test('calculates check digit for 16977837 as K', () {
        expect(calculateDv('16977837'), 'K');
      });

      test('throws ArgumentError for empty string', () {
        expect(() => calculateDv(''), throwsArgumentError);
      });

      test('throws ArgumentError for non-numeric string', () {
        expect(() => calculateDv('abc'), throwsArgumentError);
      });
    });

    group('validateRut', () {
      test('validates 5544332-7 as true', () {
        expect(validateRut('5544332-7'), true);
      });

      test('validates empty string as false', () {
        expect(validateRut(''), false);
      });
    });

    group('removeRutFormatting', () {
      test('removes formatting from 11.111.111-9', () {
        expect(removeRutFormatting('11.111.111-9'), '111111119');
      });

      test('handles empty string', () {
        expect(removeRutFormatting(''), '');
      });
    });
  });
}
