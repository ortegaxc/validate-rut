## 0.4.0

### 🎉 Major Features

- **New ValidateRut Class API**: Introduced a cleaner, more organized API with static methods
  - `ValidateRut.validate(String rut)` - Validate RUTs
  - `ValidateRut.format(String rut)` - Format RUTs with dots and hyphen
  - `ValidateRut.clean(String rut)` - Remove formatting from RUTs
  - `ValidateRut.calculateCheckDigit(String rut)` - Calculate verification digits

### 🛡️ Improvements

- **Enhanced Edge Case Handling**: Better validation for empty strings and invalid inputs
- **Improved Documentation**: Comprehensive README with examples and API reference
- **Enhanced RutInputFormatter**: Better documentation and error handling
- **Backwards Compatibility**: All existing functions remain available

### 🔧 Technical Changes

- Updated package structure for better organization
- Improved test coverage for edge cases
- Enhanced error handling across all functions
- Better validation for malformed RUT inputs

### 📚 Examples

- Added comprehensive examples for both new and legacy APIs
- Created Flutter example with real-time validation
- Added Dart-only example for non-Flutter use cases

### 🔄 Migration Guide

**Recommended (New API):**

```dart
bool isValid = ValidateRut.validate('11.111.111-1');
String formatted = ValidateRut.format('111111111');
String clean = ValidateRut.clean('11.111.111-1');
String checkDigit = ValidateRut.calculateCheckDigit('11111111');
```

**Legacy (Still Supported):**

```dart
bool isValid = validateRut('11.111.111-1');
String formatted = formatRut('111111111');
String clean = removeRutFormatting('11.111.111-1');
String checkDigit = calculateDv('11111111');
```

# 0.3.0

### ✅ Added

- Comprehensive edge case handling for empty strings, short inputs, and formatting-only inputs in RUT validation and formatting.
- More robust input validation in `validateRut`, `formatRut`, and `calculateDv` to prevent exceptions and improve UX.
- Improved and expanded test coverage for all edge cases and invalid inputs.

### 🔄 Changed

- Stricter regex for RUT validation to avoid accepting empty or invalid strings.
- `formatRut` no longer suggests valid RUTs for insufficient input length.
- Consistent behavior for all edge cases and empty inputs.

### 🐛 Fixed

- No more exceptions when clearing or entering empty input fields.
- Better handling of inputs with only formatting characters (dots, dashes, spaces).

# 0.2.2

### 🔄 Changed

- Remove unused import of 'rut_input_formatter.dart' in main.dart
- Update rutVerificationDigitRegex to allow for one or more digits before the verification digit in 'constants.dart'
- Fix condition in RutInputFormatter to return oldValue when rutVerificationDigitRegex matches unformattedRut in 'rut_input_formatter.dart'

# 0.2.1

### ✅ Added

- Add rut_input_formatter.dart to exports in validate_rut.dart

# 0.2.0

### ✅ Added

- Additional RUT to the `rutList` in `validate_rut_example.dart`.
- Print statements in `validate_rut_example.dart` for better visibility.
- RUT validation functionality in the Flutter app (`main.dart`).
- Constant for RUT verification digit regex in `constants.dart`.
- `RutInputFormatter` class in `rut_input_formatter.dart` for RUT input formatting.

### 🔄 Changed

- Optimized the call to `removeRutFormatting` function in `format_rut.dart`.
- Reorganized export statements in alphabetical order in `validate_rut.dart`.

### 🐛 Fixed

- Fixed index out of range error when formatting RUT in `format_rut.dart`.

# 0.1.0

### 🎉 Initial Release

- Initial Open Source release.
