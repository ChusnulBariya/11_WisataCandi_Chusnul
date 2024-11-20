import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';



class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //TODO: 1. deklarasikan variabel
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorText = '';
  bool _isSignedIn = false;
  bool _obscurePassword = true;

  void _signIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String savedUsername = prefs.getString('username') ?? '';
    final String savedPassword = prefs.getString('password') ?? '';
    final String enteredUsername = _usernameController.text.trim();
    final String enteredPassword = _passwordController.text.trim();

    if(enteredUsername.isEmpty || enteredPassword.isEmpty){
      setState(() {
        _errorText = 'Nama pengguna dan kata sandi harus diisi.';
      });
      return;
    }

    if(savedUsername.isEmpty || savedPassword.isEmpty){
      setState(() {
        _errorText =
        'Pengguna belum terdaftar. Silahkan daftar terlebih dahulu.';
      });
      return;
    }

    if(enteredUsername == savedUsername && enteredPassword == savedPassword){
      setState(() {
        _errorText = '';
        _isSignedIn = true;
        prefs.setBool('isSignedIn', true);
      });
      //Pemanggilan untuk menghapus semua halaman dalam tumpukan navigasi
      WidgetsBinding.instance.addPostFrameCallback((_){
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
      //Sign in berhasil, navigasikan ke layar utama
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/');
      }); 
    } else {
      setState(() {
        _errorText = 'Nama pengguna atau kata sandi.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TOD: 2.pasang AppBar
      appBar: AppBar(
        title: const Text('Sign In') ,
        ),
      //TOD: 3.pasang Body
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: Column(
                //TODO: 4. Atur MainAxisAlignment dan CrossAxisAlignment
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //TODA: 5. Pasang TextFromField nama pengguna
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: "Nama Pengguna",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  //TODA: 6. Pasang TextFromField kata sandi
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Kata Sandi",
                      errorText: _errorText.isNotEmpty ? _errorText : null,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        }, 
                        icon: Icon(_obscurePassword
                        ? Icons.visibility_off
                        :Icons.visibility
                        ),
                        ),
                    ),
                  ),
                  //TODA: 7. Pasang ElevatedButton Sign In
                  const SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () {}, 
                    child: const Text('Sign In'),
                  ),
                  //TODO: 8. Pasang TextBox Sign Up
                  const SizedBox(height: 20,),
                  TextButton(
                    onPressed: () {}, 
                    child: const Text('Belum punya akun? Daftar Disini')
                    ),
                  RichText(
                  text: TextSpan(text: 'Belum punya akun?',
                  style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                  children: <TextSpan> [
                    TextSpan(
                      text: 'Daftar Di sini',
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/signUp');
                        },
                    ),
                   ],
                  ),
                  ),
                ],
              ) 
            ),
          ),
        ),
      ),

    );

  }
}