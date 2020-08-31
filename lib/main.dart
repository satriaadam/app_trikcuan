import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trikcuan_app/onboarding_screen.dart';
import 'package:trikcuan_app/utilities/bloc_delegate.dart';
import 'login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        'onboarding_screen':(context)=> OnboardingScreen(),
        'login_screen':(context)=> LoginPage()
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final skipStartup = prefs.getBool("skipStartup") ?? false;
    if(!skipStartup) {
      Timer(Duration(seconds: 4),() {
        Navigator.of(context).popAndPushNamed('onboarding_screen');
      });
    } else {
      Timer(Duration(seconds: 4),() {
        Navigator.of(context).popAndPushNamed('login_screen');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Center(
            child: Image.asset('assets/images/logombahgiso.png',width: MediaQuery.of(context).size.width*0.5),
       ),
      ),
    );
  }
}
