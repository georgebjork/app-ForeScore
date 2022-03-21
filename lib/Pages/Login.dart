/*
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import '../Components/auth_state.dart';
import '../utils/constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends AuthState<Login> {
  bool _isLoading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });
    final response = await supabase.auth.signIn( email: _emailController.text, password: _passwordController.text);
    final error = response.error;
    if (error != null) {
      context.showErrorSnackBar(message: error.message);
    } else {
      _emailController.clear();
      _passwordController.clear();
       Navigator.of(context)
          .pushNamedAndRemoveUntil('/Home', (route) => false);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
    });
    final response = await supabase.auth.signUp(_emailController.text, _passwordController.text);
    final error = response.error;
    if (error != null) {
      context.showErrorSnackBar(message: error.message);
    } else {
      context.showSnackBar(message: 'Check your email for login link!');
      _emailController.clear();
      _passwordController.clear();
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
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
            obscureText: true
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _isLoading ? null : _signIn,
            child: Text(_isLoading ? 'Loading' : 'Login'),
          ),

         const SizedBox( height: 50, child: Center(child: Text("Or sign up here"),)),

          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {Navigator.pushNamed(context, '/signUp');},
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}

*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Utils/Providers/ThemeProvider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;


  Widget build(BuildContext context){
    final themeProvider = context.read<ThemeProvider>();
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('Log in', style: Theme.of(context).primaryTextTheme.headline2),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: ListView(
          children: [
            
            //Email address input
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextFormField(
                //Cursor color
                cursorColor: Colors.grey,

                //Keyboard
                keyboardType: TextInputType.emailAddress,

                decoration: InputDecoration(
                  //Label
                  labelText: 'Email',
                  labelStyle: Theme.of(context).primaryTextTheme.headline3,

                  //Fill the field
                  filled: true,
                  fillColor: Colors.grey.shade300,

                  //Border of the input
                  hoverColor: Colors.grey,
                  border: const OutlineInputBorder(borderSide: BorderSide(color:Colors.grey)),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  errorBorder: OutlineInputBorder(borderSide: BorderSide(color: themeProvider.getRed())),
                  focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: themeProvider.getRed())),           
                ),
              ),
            ),

            //Password input
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextFormField(
                //Cursor color
                cursorColor: Colors.grey,

                //Hide the text
                obscureText: true,

                decoration: InputDecoration(
                  //Label
                  labelText: 'Password',
                  labelStyle: Theme.of(context).primaryTextTheme.headline3,

                  //Fill the field
                  filled: true,
                  fillColor: Colors.grey.shade300,

                  //Border of the input
                  hoverColor: Colors.grey,
                  border: const OutlineInputBorder(borderSide: BorderSide(color:Colors.grey)),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  errorBorder: OutlineInputBorder(borderSide: BorderSide(color: themeProvider.getRed())),
                  focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: themeProvider.getRed())),           
                ),
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width/5,
              child: TextButton(
                
                onPressed: () {},
                child: Center(child: Text('Login', style: Theme.of(context).textTheme.headline4)),
              
                style: TextButton.styleFrom(
                  backgroundColor: themeProvider.getGreen(),
                  padding: const EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}