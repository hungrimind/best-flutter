import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _input = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Enter at least 10 characters'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Field cannot be empty';
              } else if (value.length < 10) {
                return 'Field must be at least 10 characters';
              }
              return null;
            },
            onSaved: (value) {
              _input = value ?? '';
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Saved: $_input')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
