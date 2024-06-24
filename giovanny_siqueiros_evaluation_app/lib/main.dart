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
          scaffoldBackgroundColor: Colors.black,
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
  double _opacityLevel1 = 0.0;
  double _opacityLevel2 = 0.0;
  double _opacityLevel3 = 0.0;

  @override
  void initState() {
    super.initState();
    _startFadeInSequence();
  }

  Future<void> _startFadeInSequence() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _opacityLevel1 = 1.0;
    });
    await Future.delayed(Duration(milliseconds: 2000));
    setState(() {
      _opacityLevel2 = 1.0;
    });
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      _opacityLevel3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedOpacity(
            opacity: _opacityLevel1,
            duration: Duration(seconds: 1),
            child: Image.asset(
              'assets/images/rickmortybgspace4.jpg',
              fit: BoxFit.cover,
            ),
          ),
          AnimatedOpacity(
            opacity: _opacityLevel2,
            duration: Duration(seconds: 1),
            child: Image.asset(
              'assets/images/rickmortybg6.png',
              fit: BoxFit.cover,
            ),
          ),
          AnimatedOpacity(
            opacity: _opacityLevel3,
            duration: Duration(seconds: 1),
            child: Image.asset(
              'assets/images/rickmortybg6.png',
              fit: BoxFit.cover,
            ),
          ),
          if (_opacityLevel3 == 1.0)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          transitionDuration: Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.transparent,
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
