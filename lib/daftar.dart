import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_bloc.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_event.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_state.dart';
import 'package:trikcuan_app/core/model/account_model.dart';
import 'package:trikcuan_app/widget/button.dart';
import 'package:trikcuan_app/widget/form.dart';

import 'pages/home_page.dart';

class Daftar extends StatefulWidget {
  @override
  _DaftarState createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {

  bool isLoading = false;
  final bloc = AuthBloc();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if(state is RegisterSuccess) {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(
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
        backgroundColor: Colors.grey.shade100,
        resizeToAvoidBottomPadding: false,
        body: ListView(
          padding: EdgeInsets.only(bottom: 80),
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 100.0, 0.0, 10.0),
                  //  child: Text(
                  //    'Registrasi',
                  //    style: TextStyle(
                  //        fontFamily: 'Poppins',
                  //        fontSize: 30.0,
                  //        color: Colors.grey.shade700,
                  //    ),
                  //  ),
                  ),
                ]
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextFieldBox(
                    controller: nameController,
                    textHint: "Nama",
                    prefixIcon: Icons.person,
                  ),
                  SizedBox(height: 15.0),
                  TextFieldBox(
                    controller: usernameController,
                    textHint: "Username",
                    prefixIcon: Icons.account_circle,
                  ),
                  SizedBox(height: 15.0),
                  TextFieldBox(
                    controller: emailController,
                    textHint: "Email",
                    inputType: TextInputType.emailAddress,
                    prefixIcon: Icons.mail,
                  ),
                  SizedBox(height: 15.0),
                  TextFieldBox(
                    controller: phoneNumberController,
                    inputType: TextInputType.phone,
                    textHint: "No Hp",
                    prefixIcon: Icons.phone,
                  ),
                  SizedBox(height: 20.0),
                  TextFieldBox(
                    controller: passwordController,
                    textHint: "Password",
                    isObsecure: true,
                    prefixIcon: Icons.lock,
                  ),
                  SizedBox(height: 50.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButtonPrimary(
                      text: "DAFTAR",
                      isLoading: isLoading,
                      radius: 50,
                      padding: 16,
                      fontSize: 14,
                      onPressed: () => !isLoading ? register() : null,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: OutlineButtonPrimary(
                      radius: 50,
                      padding: 16,
                      text: "KEMBALI",
                      fontSize: 14,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              )
            ),
          ]
        )
      ),
    );
  }

  register() {
    if(nameController.text == null || nameController.text == "")
      Toast.show("Nama harus diisi", context);
    else if(usernameController.text == null || usernameController.text == "")
      Toast.show("Username harus diisi", context);
    else if(emailController.text == null || emailController.text == "")
      Toast.show("Email harus diisi", context);
    else if(phoneNumberController.text == null || phoneNumberController.text == "")
      Toast.show("Nomor HP harus diisi", context);
    else if(passwordController.text == null || passwordController.text == "")
      Toast.show("Password harus diisi", context);
    else if(passwordController.text.length < 6)
      Toast.show("Password minimal 6 karakter", context);
    else {
      final data = RegisterAccount();
      data.name = nameController.text;
      data.username = usernameController.text;
      data.email = emailController.text;
      data.phoneNumber = phoneNumberController.text;
      data.password = passwordController.text;
      bloc.add(Register(data: data));
      setState(() {
        isLoading = true;
      });
    }
  }
}