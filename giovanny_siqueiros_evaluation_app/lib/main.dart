import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:giovanny_siqueiros_evaluation_app/providers/character_provider.dart';
import 'package:giovanny_siqueiros_evaluation_app/screens/home_screen.dart';
import 'package:giovanny_siqueiros_evaluation_app/screens/recently_viewed_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CharacterProvider(),
      child: MaterialApp(
        title: 'Rick and Morty App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
        routes: {
          '/home': (context) => HomeScreen(),
          '/recently-viewed': (context) => RecentlyViewedScreen(),
        },
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/rickmortybg6.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text('Catálogo de Personajes'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
