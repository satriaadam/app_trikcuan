import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_bloc.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_event.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_state.dart';
import 'package:trikcuan_app/widget/button.dart';
import 'package:trikcuan_app/widget/form.dart';

import 'pages/curvedapp.dart';

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
            builder: (context) => App()
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 150.0, 0.0, 0.0),
                    child: Text('Login', style: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold
                    )),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextFieldBorderBottom(
                    controller: usernameController,
                    textHint: "USERNAME",
                    icon: Icons.person,
                  ),
                  SizedBox(height: 20.0),
                  TextFieldBorderBottom(
                    controller: passwordController,
                    textHint: "PASSWORD",
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
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          decoration: TextDecoration.underline
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButtonPrimary(
                      text: "Login",
                      isLoading: isLoading,
                      radius: 50,
                      padding: 16,
                      onPressed: () => !isLoading ? login() : null,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: OutlineButtonPrimary(
                      radius: 50,
                      padding: 16,
                      text: "Daftar",
                      onPressed: () {},
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