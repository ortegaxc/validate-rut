# Validate RUT

A comprehensive Dart package for the validation and formatting of the Chilean Unique Tax Role (RUT).

## Features

- ✅ **RUT Validation**: Validate Chilean RUTs using the official modulo 11 algorithm
- 🎨 **RUT Formatting**: Format RUTs with dots and hyphen (e.g., "12.345.678-9")
- 🧹 **RUT Cleaning**: Remove formatting characters from RUTs
- 🔢 **Check Digit Calculation**: Calculate the verification digit for any RUT
- 📱 **Flutter Input Formatter**: Real-time RUT formatting for Flutter text fields
- 🛡️ **Edge Case Handling**: Robust handling of empty strings and invalid inputs
- 🎯 **Modern API**: New class-based API with backwards compatibility

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  validate_rut: ^0.4.0
```

## Usage

### New Class-Based API (Recommended)

```dart
import 'package:validate_rut/validate_rut.dart';

// Validate a RUT
bool isValid = ValidateRut.validate('11.111.111-1');
print(isValid); // true

// Clean a RUT (remove formatting)
String cleanRut = ValidateRut.clean('11.111.111-1');
print(cleanRut); // 111111111

// Format a RUT
String formattedRut = ValidateRut.format('111111111');
print(formattedRut); // 11.111.111-1

// Calculate check digit
String checkDigit = ValidateRut.calculateCheckDigit('11111111');
print(checkDigit); // 1
```

### Individual Functions (Backwards Compatibility)

```dart
import 'package:validate_rut/validate_rut.dart';

// Validate a RUT
bool isValid = validateRut('11.111.111-1');

// Format a RUT
String formatted = formatRut('111111111');

// Remove formatting
String clean = removeRutFormatting('11.111.111-1');

// Calculate verification digit
String dv = calculateDv('11111111');
```

### Flutter Input Formatter

For Flutter applications, you can use the `RutInputFormatter` to format RUTs as users type:

```dart
import 'package:flutter/material.dart';
import 'package:validate_rut/validate_rut.dart';

TextFormField(
  inputFormatters: [RutInputFormatter()],
  decoration: InputDecoration(
    labelText: 'RUT',
    hintText: '12.345.678-9',
    helperText: 'The format will be applied automatically',
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid RUT';
    }
    if (!ValidateRut.validate(value)) {
      return 'RUT inválido';
    }
    return null;
  },
)
```

## Examples

### Validation Examples

```dart
// Valid RUTs
ValidateRut.validate('11.111.111-1');  // true
ValidateRut.validate('11111111-1');    // true
ValidateRut.validate('22222222-2');    // true

// Invalid RUTs
ValidateRut.validate('11111111-2');    // false (wrong check digit)
ValidateRut.validate('abc');           // false (invalid format)
ValidateRut.validate('');              // false (empty string)
```

### Formatting Examples

```dart
// Format a clean RUT
ValidateRut.format('111111111');    // "11.111.111-1"
ValidateRut.format('11111111');     // "1.111.111-1"
ValidateRut.format('1111111');      // "111.111-1"

// Clean a formatted RUT
ValidateRut.clean('11.111.111-1');  // "111111111"
ValidateRut.clean('11111111-1');    // "111111111"
```

### Check Digit Examples

```dart
// Calculate check digits
ValidateRut.calculateCheckDigit('11111111');  // "1"
ValidateRut.calculateCheckDigit('22222222');  // "2"
ValidateRut.calculateCheckDigit('12345678');  // "5"
```

## API Reference

### ValidateRut Class

#### `ValidateRut.validate(String rut) → bool`

Validates a Chilean RUT using the modulo 11 algorithm.

**Parameters:**

- `rut`: The RUT string to validate (with or without formatting)

**Returns:** `true` if the RUT is valid, `false` otherwise

#### `ValidateRut.format(String rut) → String`

Formats a RUT with dots and hyphen (e.g., "12.345.678-9").

**Parameters:**

- `rut`: The RUT string to format

**Returns:** Formatted RUT string

#### `ValidateRut.clean(String rut) → String`

Removes all formatting characters from a RUT.

**Parameters:**

- `rut`: The RUT string to clean

**Returns:** Clean RUT string with only numbers and check digit

#### `ValidateRut.calculateCheckDigit(String rut) → String`

Calculates the verification digit for a RUT number.

**Parameters:**

- `rut`: The RUT number (without check digit)

**Returns:** The calculated check digit ("0"-"9" or "K")

### RutInputFormatter Class

#### `RutInputFormatter()`

A Flutter `TextInputFormatter` that automatically formats RUT input with dots and hyphen as the user types.

## Breaking Changes in v0.4.0

- **New recommended API**: Use `ValidateRut.validate()` instead of `validateRut()`
- **Improved error handling**: Better handling of edge cases and invalid inputs
- **Enhanced documentation**: Comprehensive examples and API reference
- **Backwards compatibility**: All previous functions still work

## Migration Guide

### From v0.3.x to v0.4.0

**Old way:**

```dart
bool isValid = validateRut('11.111.111-1');
String formatted = formatRut('111111111');
```

**New way (recommended):**

```dart
bool isValid = ValidateRut.validate('11.111.111-1');
String formatted = ValidateRut.format('111111111');
```

The old functions still work for backwards compatibility.

## Algorithm Details

This package implements the official Chilean RUT validation algorithm using modulo 11:

1. Remove all formatting characters
2. Separate the verification digit from the number
3. Calculate the sum of the number digits multiplied by decreasing factors (2,3,4,5,6,7,2,3,4...)
4. Calculate the modulo 11 of the sum
5. The check digit is 11 minus the modulo, with special cases:
   - If result is 11, check digit is 0
   - If result is 10, check digit is K

## Complete Example

```dart
import 'package:validate_rut/validate_rut.dart';

void main() {
  // Using the new ValidateRut class (recommended)
  print('=== New API ===');

  String rut = '11.111.111-1';
  print('RUT: $rut');
  print('Valid: ${ValidateRut.validate(rut)}');
  print('Clean: ${ValidateRut.clean(rut)}');
  print('Formatted: ${ValidateRut.format(ValidateRut.clean(rut))}');
  print('Check digit: ${ValidateRut.calculateCheckDigit('11111111')}');

  // Using individual functions (backwards compatibility)
  print('\n=== Legacy API ===');
  print('Valid: ${validateRut(rut)}');
  print('Clean: ${removeRutFormatting(rut)}');
  print('Formatted: ${formatRut('111111111')}');
  print('Check digit: ${calculateDv('11111111')}');
}
```

## Testing

Run the tests with:

```bash
dart test
# or for Flutter projects:
flutter test
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

Tomás Ortega - [ortegaxc.05@gmail.com](mailto:ortegaxc.05@gmail.com)

## Links

- [GitHub Repository](https://github.com/ortegaxc/validate-rut)
- [Pub.dev Package](https://pub.dev/packages/validate_rut)
