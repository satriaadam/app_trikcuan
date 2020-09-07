import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_bloc.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_event.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_state.dart';
import 'package:trikcuan_app/widget/button.dart';
import 'package:trikcuan_app/widget/form.dart';

import 'daftar.dart';
import 'pages/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool isLoading = false;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final bloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if(state is AuthLoginSuccess) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => HomePage()
          ));
          setState(() {
            isLoading = false;
          });
        } else if(state is AuthFailure) {
          Toast.show(state.error, context);
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.grey.shade100,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(110.0, 160.0, 110.0, 5.0),
                    child: Image.asset('assets/images/logoopanjangmbahgiso.jpeg',width: MediaQuery.of(context).size.width*0.5),
                  ),
                 // Container(
                 //   padding: EdgeInsets.fromLTRB(20.0, 180.0, 0.0, 0.0),
                 //   child: Text('Login', style: TextStyle(
                 //     color: Colors.grey.shade700,
                 //     fontSize: 35.0,
                   //   letterSpacing: 1.2,
                   //   fontWeight: FontWeight.bold,
                 //     fontFamily: 'Poppins',
                 //   )),
                 // ),
                ],
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextFieldBorderBottom(
                    controller: usernameController,
                    textHint: "Username",
                    icon: Icons.person,
                  ),
                  SizedBox(height: 15.0),
                  TextFieldBorderBottom(
                    controller: passwordController,
                    textHint: "Password",
                    isObsecure: true,
                    icon: Icons.lock,
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    alignment: Alignment(1.0, 0.0),
                    padding: EdgeInsets.only(top: 15.0, left: 20.0),
                    child: InkWell(
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          decoration: TextDecoration.underline
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 75.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButtonPrimary(
                      text: "Login",
                      isLoading: isLoading,
                      radius: 50,
                      padding: 16,
                      fontSize: 14,
                      onPressed: () => !isLoading ? login() : null,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: OutlineButtonPrimary(
                      radius: 50,
                      padding: 16,
                      text: "Registrasi",
                      fontSize: 14,
                      onPressed: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Daftar()
                      )),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  login() {
    bloc.add(Login(username: usernameController.text, password: passwordController.text));
    setState(() {
      isLoading = true;
    });
  }
}