# RUT Validator

RUT Validator is a Dart package that provides utilities for the validation and formatting of the Chilean Rol Único Tributario (RUT). This is a unique identifier used in Chile for both businesses and individuals. The utilities in this package implement the official algorithm published by the Chilean registry office.

## Features

- RUT validation
- Calculation of the RUT's check digit
- Formatting and de-formatting of RUT
- RUT input formatter

## Getting Started

Add `validate_rut` as a dependency in your `pubspec.yaml` file:

```
dependencies:
  validate_rut: ^version_number
```

## **Usage**

Import the package:

```dart
import 'package:validate_rut/validate_rut.dart';
```

## Validation

```dart
String rut = '111111119';
bool isValid = validateRut(rut); // false

rut = '11.111.111-9';
isValid = validateRut(rut); // false
```

## ****Formatting****

```dart
String rut = '111111119';
String formattedRut = formatRut(rut); // 11.111.111-9

formattedRut = '11.111.111-9';
rut = removeRutFormatting(formattedRut); // 111111119
```

## **Tests**

To run the tests, use the **`dart test`** command in your terminal.

## **License**

Include information about your package's license here.

## **Contributions**

Contributions are welcome! If you find a bug please report it and if you want a feature please report it. If you want to contribute code, please submit a pull request.

## **License**

This package is licensed under the MIT License. See the LICENSE file for more details.

## **Support**

If you encounter any problems or have questions, feel free to open an issue on the GitHub repository.

## **From the Developers**

We hope that this package helps you on your Flutter projects and makes handling the RUT a breeze!