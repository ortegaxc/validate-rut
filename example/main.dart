import 'package:flutter/material.dart';
import 'package:validate_rut/validate_rut.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RUT Validator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'RUT Validator Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController rutController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String validationResult = '';

  void _validateRut() {
    validationResult = '';
    if (formKey.currentState!.validate()) {
      String rut = rutController.text;

      // Using the new ValidateRut class (recommended)
      bool isValid = ValidateRut.validate(rut);
      String cleanRut = ValidateRut.clean(rut);
      String formattedRut = ValidateRut.format(cleanRut);
      String checkDigit = ValidateRut.calculateCheckDigit(cleanRut);

      if (isValid) {
        validationResult = '''✅ RUT válido
            RUT limpio: $cleanRut
            RUT formateado: $formattedRut
            Dígito verificador: $checkDigit''';
      } else {
        validationResult = '❌ RUT inválido';
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: rutController,
                inputFormatters: [
                  RutInputFormatter(),
                ],
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'RUT',
                  hintText: '12.345.678-9',
                  border: OutlineInputBorder(),
                  helperText: 'The format will be applied automatically',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a RUT';
                  }
                  if (!ValidateRut.validate(value)) {
                    return 'Invalid RUT';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _validateRut,
                child: Text('Validate RUT'),
              ),
              SizedBox(height: 20),
              if (validationResult.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: validationResult.contains('✅')
                        ? Colors.green.shade50
                        : Colors.red.shade50,
                    border: Border.all(
                      color: validationResult.contains('✅')
                          ? Colors.green
                          : Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    validationResult,
                    style: TextStyle(
                      color: validationResult.contains('✅')
                          ? Colors.green.shade800
                          : Colors.red.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    rutController.dispose();
    super.dispose();
  }
}
