import 'package:flutter/material.dart';
import 'package:wisata_candi/data/candi_data.dart';
import 'package:wisata_candi/screens/home_screen.dart';
import 'package:wisata_candi/screens/profile_screen.dart';
import 'package:wisata_candi/screens/sign_in.dart';
import 'package:wisata_candi/screens/favorite_screen.dart';
import 'package:wisata_candi/screens/sign_up_screen.dart';
import 'screens/detail_screen.dart';
import 'package:wisata_candi/screens/search_screen.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisata Candi',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.deepPurple),
          titleTextStyle: TextStyle(
            color: Colors.deepPurple,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
        primary: Colors.deepPurple,
        surface: Colors.deepPurple[50],
       ),
       useMaterial3: true,
          ),
      // home: DetailScreen(candi: candiList[0]),
      // home: const ProfileScreen()
      // home: SignInScreen(),
      // home: SignUpScreen(),
      // home: SearchScreen(),
      // home: MainScreen(),
      home:FlutterSplashScreen.fadeIn(
        backgroundColor: const Color.fromRGBO(255, 248, 242, 1),
        childWidget: SizedBox(
          height: 200,
          width: 200,
          child: Image.asset("Images/th.jpg"),
        ),

        nextScreen: const SignInScreen(),
      ),
      initialRoute: '/',
      routes: {
        '/mainScreen': (context) => const MainScreen(),
        '/homeScreen': (context) => const HomeScreen(),
        '/signIn': (context) => const SignInScreen(),
        '/signUp': (context) => const SignUpScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

   //TODO: 1. Deklarasikan variabel
    int _currentIndex = 0;
    final List<Widget> _children = [
      HomeScreen(),
      SearchScreen(),
      FavoriteScreen(),
      ProfileScreen(),
    ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: 2. Buat properti body berupa widget yang ditampilkan 
      body: _children[_currentIndex],
      
      //TODO: 3. Buat properti bottomNavigationBar dengan nilai Theme 
      bottomNavigationBar: 
      Theme(
      //TODO: 4. Buat data dan child dari theme 
        data: Theme.of(context).copyWith(
          canvasColor: Colors.deepPurple[50],
        ), 
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index){
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.deepPurple,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.deepPurple,),
              label: 'Search',
              ),
               BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.deepPurple,),
              label: 'Favorite',
              ),
               BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.deepPurple,),
              label: 'Profile',
              ),
            ], 
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.deepPurple[100],
          showUnselectedLabels: true,
          ),
          ), 
     
    );
  }
}

