import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_bloc.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_event.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_state.dart';
import 'package:trikcuan_app/widget/button.dart';
import 'package:trikcuan_app/widget/form.dart';

import 'login_page.dart';
import 'pages/home_page.dart';

class ForgotPassPage extends StatefulWidget {
  @override
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {

  bool isLoading = false;
  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();
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
        appBar: AppBar(
          elevation: 0.0,
          leading: Icon(Icons.arrow_back, color: Colors.transparent),
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close, size: 35.0),
            onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => LoginPage())
                );
            },
            )
          ],
        ),
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.grey.shade100,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 0.0),
                  child: Icon(
                    Icons.lock_outline,
                    size: 125.0,
                    color: Color(0xFF234E65),
                  ),
            ),
            SizedBox(height: 5.0),
            Container(
              alignment: Alignment.center,
              child: Text('Trouble loggin in?', style: TextStyle(
                fontSize: 18.0,
                color: Colors.black87,
              ),),
            ),
            SizedBox(height: 5.0),
            Container(
              alignment: Alignment.center,
              child: Text("Enter your phone number and we'll send\nyou a code to get back into your account.", style: TextStyle(
                fontSize: 12.0,
                color: Colors.black87,
              ),),
            ),
            SizedBox(height: 5.0),
            Container(
              padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextFieldBorderBottom(
                    controller: phoneNumberController,
                    textHint: "Phone Number",
                    prefixIcon: Icons.phone,
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButtonPrimary(
                      text: "Lanjut",
                      isLoading: isLoading,
                      radius: 50,
                      padding: 16,
                      fontSize: 14,
                      onPressed: () => !isLoading ? detail() : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  detail() {
    bloc.add(Login(username: usernameController.text, password: phoneNumberController.text));
    setState(() {
      isLoading = true;
    });
  }
}