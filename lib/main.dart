import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(FormValidationApp());
}

class FormValidationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Validation',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late String _email;
  late String _password;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      print('Email: $_email');
      print('Password: $_password');

      print('Signed in successfully');

      _emailController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Validation'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!_isValidEmail(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                    return 'Password must contain at least one special character';
                  }
                  if (!value.contains(RegExp(r'[A-Z]'))) {
                    return 'Password must contain at least one uppercase letter';
                  }
                  if (!value.contains(RegExp(r'[a-z]'))) {
                    return 'Password must contain at least one lowercase letter';
                  }
                  if (!value.contains(RegExp(r'[0-9]'))) {
                    return 'Password must contain at least one digit';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: _validateForm,
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  bool _isValidEmail(String value) {
    // Use a regular expression pattern to validate email addresses
    final pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(value);
  }
}
