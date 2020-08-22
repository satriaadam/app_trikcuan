import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trikcuan_app/onboarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        'onboarding_screen':(context)=> OnboardingScreen()
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void startTimer() {
    Timer(Duration(seconds: 3),() {
      Navigator.of(context).popAndPushNamed('onboarding_screen');
    });
  }
  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/hl_bg_banner.jpg'),
              fit: BoxFit.cover
          ),
        ),
          child: Center(
            child: Image.asset('assets/images/trikcuanlogo.png',width: MediaQuery.of(context).size.width*1),
       ),
      ),
    );
  }
}
