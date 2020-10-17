import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_bloc.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_event.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_state.dart';
import 'package:trikcuan_app/core/model/account_model.dart';
import 'package:trikcuan_app/login_page.dart';
import 'package:trikcuan_app/pages/admin/recomendation/recomendation_page.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  final bloc = AuthBloc();
  Account account;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          cubit: bloc,
          listener: (context, state) {
            if(state is AuthUnauthenticated) {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => LoginPage()
              ));
            }
          },
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("Rekomendasi")
        ),
        body: ListView(
          children: [
            Divider(),
            ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => AdminRecomendationPage()
              )),
              title: Text("Rekomendasi")
            ),
            Divider(),
            SizedBox(height: 32),
            Divider(),
            ListTile(
              onTap: () => bloc.add(Logout()),
              title: Text("Logout")
            ),
            Divider(),
          ]
        ),
      ),
    );
  }
}