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
      home: MyHomePage(title: 'RUT Validator Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  final TextEditingController rutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              inputFormatters: [
                RutInputFormatter(),
              ],
              controller: rutController,
              decoration: InputDecoration(
                labelText: 'Enter RUT',
              ),
              validator: (value) {
                if (value == null || !validateRut(value)) {
                  return 'Please enter a valid RUT';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (Form.of(context).validate()) {
                  // All fields are valid, you can process the data.
                } else {
                  // One or more fields are invalid, displays an error message.
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
