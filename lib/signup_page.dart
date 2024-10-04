import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _password = '';
  String _email = '';
  String _phone = '';
  String _profession = 'Engineer';

  List<String> professions = ['Engineer', 'Doctor', 'Teacher', 'Artist'];

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', _name);
      await prefs.setString('password', _password);
      await prefs.setString('email', _email);
      await prefs.setString('phone', _phone);
      await prefs.setString('profession', _profession);
      Navigator.pop(context); // Go back to login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your name' : null,
                onChanged: (value) => _name = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) =>
                    value!.length < 6 ? 'Password too short' : null,
                onChanged: (value) => _password = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)
                        ? 'Enter a valid email'
                        : null,
                onChanged: (value) => _email = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) =>
                    value!.length < 10 ? 'Enter a valid phone number' : null,
                onChanged: (value) => _phone = value,
              ),
              DropdownButtonFormField<String>(
                value: _profession,
                items: professions
                    .map((profession) => DropdownMenuItem(
                          value: profession,
                          child: Text(profession),
                        ))
                    .toList(),
                onChanged: (value) => setState(() {
                  _profession = value!;
                }),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}