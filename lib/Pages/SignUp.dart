import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Components/auth_state.dart';
import '../utils/constants.dart';

class SignUp extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends AuthState<SignUp> {
  bool _isLoading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _handicapController = TextEditingController();

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
    });

    final response = await supabase.auth
        .signUp(_emailController.text, _passwordController.text);
    final error = response.error;
    if (error != null) {
      context.showErrorSnackBar(message: error.message);
    } else {
      //context.showSnackBar(message: 'Check your email for login link!');
      

      final res = await supabase 
      .from('users')
      .insert([{
        'id' : supabase.auth.currentUser?.id,
        'first_name' : _firstNameController.text,
        'last_name' : _lastNameController.text,
        'handicap' : double.parse(_handicapController.text)
      }])
      .execute();
      final error = res.error;
      if(error != null){
        context.showErrorSnackBar(message: error.message);
      } else{
        _emailController.clear();
        _passwordController.clear();
        _firstNameController.clear();
        _lastNameController.clear();
        _handicapController.clear();

        Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (route) => false);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Sign Up')),
        body: ListView(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            children: [
              const Text('Sign in using an email and password'),
              const SizedBox(height: 18),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 18),
              TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true),
              const SizedBox(height: 18),
              TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(labelText: 'First Name'),
                  ),
              const SizedBox(height: 18),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
              ),

              const SizedBox(height: 18),
              TextFormField(
                controller: _handicapController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Current Handicap'),
              ),

              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: _isLoading ? null : _signUp,
                child: Text(_isLoading ? 'Loading' : 'Submit'),
              ),
            ]));
  }
}
