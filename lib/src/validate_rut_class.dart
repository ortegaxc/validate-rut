import 'calculate_dv.dart';
import 'format_rut.dart';
import 'remove_rut_formatting.dart';
import 'validate_rut.dart';

/// Main class for Chilean RUT (Unique Tax Role) validation and formatting utilities.
///
/// This class provides static methods for validating, formatting, and manipulating
/// Chilean RUT numbers in a clean and organized way.
///
/// Example usage:
/// ```dart
/// // Validate a RUT
/// bool isValid = ValidateRut.validate('12.345.678-9');
///
/// // Format a RUT
/// String formatted = ValidateRut.format('123456789');
///
/// // Calculate check digit
/// String checkDigit = ValidateRut.calculateCheckDigit('12345678');
///
/// // Remove formatting
/// String clean = ValidateRut.clean('12.345.678-9');
/// ```
class ValidateRut {
  // Private constructor to prevent instantiation
  ValidateRut._();

  /// Validates a Chilean RUT number.
  ///
  /// Returns `true` if the RUT is valid, `false` otherwise.
  /// Handles various input formats including dots, dashes, and spaces.
  ///
  /// Example:
  /// ```dart
  /// bool isValid = ValidateRut.validate('12.345.678-9'); // true or false
  /// bool isValid2 = ValidateRut.validate('123456789'); // true or false
  /// ```
  static bool validate(String rut) {
    return validateRut(rut);
  }

  /// Formats a RUT string with Chilean standard formatting (dots and dash).
  ///
  /// Takes an unformatted or partially formatted RUT and returns it
  /// in the standard Chilean format: XX.XXX.XXX-X
  ///
  /// Example:
  /// ```dart
  /// String formatted = ValidateRut.format('123456789'); // '12.345.678-9'
  /// String formatted2 = ValidateRut.format('12345678-9'); // '1.234.567-8-9'
  /// ```
  static String format(String rut) {
    return formatRut(rut);
  }

  /// Calculates the check digit (verification digit) for a RUT number.
  ///
  /// Takes the main RUT number (without check digit) and returns
  /// the calculated check digit (0-9 or K).
  ///
  /// Throws [ArgumentError] if the input is empty or contains non-digit characters.
  ///
  /// Example:
  /// ```dart
  /// String checkDigit = ValidateRut.calculateCheckDigit('12345678'); // '5' or 'K'
  /// ```
  static String calculateCheckDigit(String rutNumber) {
    return calculateDv(rutNumber);
  }

  /// Removes all formatting from a RUT string.
  ///
  /// Strips dots, dashes, and spaces, leaving only digits and the check digit.
  ///
  /// Example:
  /// ```dart
  /// String clean = ValidateRut.clean('12.345.678-9'); // '123456789'
  /// String clean2 = ValidateRut.clean(' 1.234.567-8 '); // '12345678'
  /// ```
  static String clean(String rut) {
    return removeRutFormatting(rut);
  }

  /// Checks if a string represents a valid RUT format (without validation).
  ///
  /// This method only checks if the format looks like a RUT,
  /// but doesn't validate the check digit.
  ///
  /// Example:
  /// ```dart
  /// bool hasValidFormat = ValidateRut.hasValidFormat('12.345.678-9'); // true
  /// bool hasValidFormat2 = ValidateRut.hasValidFormat('abc'); // false
  /// ```
  static bool hasValidFormat(String rut) {
    final cleanRut = clean(rut);
    return cleanRut.length >= 8 &&
        cleanRut.length <= 9 &&
        RegExp(r'^\d+[0-9Kk]$').hasMatch(cleanRut);
  }

  /// Generates a formatted RUT with check digit from a base number.
  ///
  /// Takes a base RUT number, calculates its check digit,
  /// and returns the complete formatted RUT.
  ///
  /// Example:
  /// ```dart
  /// String completeRut = ValidateRut.generateComplete('12345678'); // '1.234.567-8'
  /// ```
  static String generateComplete(String rutNumber) {
    final checkDigit = calculateCheckDigit(rutNumber);
    return format(rutNumber + checkDigit);
  }
}
