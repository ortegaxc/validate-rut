# 0.2.1
### Added
- Add rut_input_formatter.dart to exports in validate_rut.dart

### Changed
- Remove unused import of 'rut_input_formatter.dart' in main.dart

# 0.2.0
### Added
- Additional RUT to the `rutList` in `validate_rut_example.dart`.
- Print statements in `validate_rut_example.dart` for better visibility.
- RUT validation functionality in the Flutter app (`main.dart`).
- Constant for RUT verification digit regex in `constants.dart`.
- `RutInputFormatter` class in `rut_input_formatter.dart` for RUT input formatting.

### Changed
- Optimized the call to `removeRutFormatting` function in `format_rut.dart`.
- Reorganized export statements in alphabetical order in `validate_rut.dart`.

### Fixed
- Fixed index out of range error when formatting RUT in `format_rut.dart`.

# 0.1.0

- Initial Open Source release.
