import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
  //TODO: 1. deklarasikan variabel
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  
  String _errorText = '';
  bool _isSignedIn = false;
  bool _obscurePassword = true;

  //TODO: 1. Membuat fungsi _signUp
  void _signUp() async{
   final SharedPreferences prefs = await SharedPreferences.getInstance(); 
   final String name = _nameController.text.trim();
   final String username = _usernameController.text.trim();
   final String password = _passwordController.text.trim();
     if (password.length < 8 ||
      !password.contains(RegExp(r'[A-Z]')) ||
      !password.contains(RegExp(r'[a-z]')) ||
      !password.contains(RegExp(r'[0-9]')) ||
      !password.contains(RegExp(r'[@#$%^&*(),.?":{}|<>]'))) {
        setState(() {
            _errorText =
          'Minimal 8 karakter, kombinasi [A-Z], [a-z], [0-9], [!@#\\\$%^&*(),.?":{}|<>]';
        });
        return;
    }
    //simpan data pengguna di SharedPreferences
    prefs.setString('fulname', name);
    prefs.setString('username', username);
    prefs.setString('password', password);
    // print('***Sign up berhasil!');
    // print('Nama: $name');
    // print('Nama Pengguna: $username');
    // print('Password: $password');

     //buat navigasi ke SignInScreen
  Navigator.pushReplacementNamed(context, '/signin');

  }

 



  //TODO: 2. Membuat fungsi dispose
  @override
  void dispose(){
    //TODO: implement dispose
    super.dispose();
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: 2.pasang AppBar
      appBar: AppBar(
        title: const Text('Sign Up') ,
        ),
      //TODO: 3.pasang Body
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
                  //TODO: 9. Pasang TextFormField Nama Pengguna
                    TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Nama",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  //TODA: 5. Pasang TextFromField nama pengguna
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: "Nama Pengguna",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  //TODA: 6. Pasang TextFromField kata sandi
                  const SizedBox(height: 20,),
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
                    child: const Text('Sign Up'),
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
                        ..onTap = () {},
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