import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

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

  Future<Map<String, String>> _retrieveAndDecryptDataFromPrefs(
    Future<SharedPreferences> prefs,
  ) async {
    final SharedPreferences = await prefs;
    final encryptedUsername = SharedPreferences.getString('username') ?? '';
    final encryptedPassword = SharedPreferences.getString('password') ?? '';
    final keyString = SharedPreferences.getString('key') ?? '';
    final ivString = SharedPreferences.getString('iv') ?? '';

    final encrypt.Key key = encrypt.Key.fromBase64(keyString);
    final iv = encrypt.IV.fromBase64(ivString);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decryptedUsername =encrypter.decrypt64(encryptedUsername, iv: iv);
    final decryptedPassword = encrypter.decrypt64(encryptedPassword, iv: iv);

    //mengembalikan data terdekripsi
    return{'username' : decryptedUsername, 'password' : decryptedPassword};
  }

 void _signIn() async {
    try {
      final Future<SharedPreferences> prefsFuture =
          SharedPreferences.getInstance();
      final String username = _usernameController.text;
      final String password = _passwordController.text;
      print('Sign in attempt');
      if (username.isNotEmpty && password.isNotEmpty) {
        final SharedPreferences prefs = await prefsFuture;
        final data = await _retrieveAndDecryptDataFromPrefs(
            prefs as Future<SharedPreferences>);
        if (data.isNotEmpty) {
          final decryptedUsername = data['username'];
          final decryptedPassword = data['password'];
          if (username == decryptedUsername && password == decryptedPassword) {
            _errorText = '';
            _isSignedIn = true;
            prefs.setBool('isSignedIn', true);
            // Pemanggilan untuk menghapus semua halaman dalam tumpukan navigasi
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            });
            // Sign in berhasil, navigasikan ke layar utama
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/');
            });
            print('Sign in succeeded');
          } else {
            print('Username or password is incorrect');
          }
        } else {
          print('No stored credentials found');
        }
      } else {
        print('Username and password cannot be empty');
        // Tambahkan pesan untuk kasus ketika username atau password kosong
      }
    } catch (e) {
      print('An error occurred: $e');
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