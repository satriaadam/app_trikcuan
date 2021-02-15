import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_bloc.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_event.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_state.dart';
import 'package:trikcuan_app/login_page.dart';
import 'package:trikcuan_app/onboarding_screen.dart';
import 'package:trikcuan_app/pages/admin/admin_page.dart';
import 'package:trikcuan_app/pages/home_page.dart';
import 'package:trikcuan_app/utilities/bloc_delegate.dart';

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
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          color: Color(0xFF009eeb),
          elevation: 1,
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700
            )
          ),
          iconTheme: IconThemeData(
            color: Colors.white
          )
        ),
        dividerTheme: DividerThemeData(
          color: Colors.grey[300],
          thickness: 1,
          space: 0,
          indent: 0
        )
      ),
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

  final bloc = AuthBloc();

  @override
  void initState() {
    super.initState();
    bloc.add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        cubit: bloc,
        listener: (context, state) async {
          if(state is AuthUnauthenticated) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            final skipStartup = prefs.getBool("skipStartup") ?? false;
            if(!skipStartup) {
              Navigator.of(context).popAndPushNamed('onboarding_screen');
            } else {
              Navigator.of(context).popAndPushNamed('login_screen');
            }
          }
          else if(state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => state.data.roleId == "2" ? HomePage() : AdminPage()),
            );
          } 
        },
        child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            child: Center(
              child: Image.asset('assets/images/logombahgiso.png',width: MediaQuery.of(context).size.width*0.5),
         ),
        ),
      ),
    );
  }
}
