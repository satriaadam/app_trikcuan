import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indonesia/indonesia.dart';
import 'package:trikcuan_app/core/bloc/account/account_bloc.dart';
import 'package:trikcuan_app/core/bloc/account/account_event.dart';
import 'package:trikcuan_app/core/bloc/account/account_state.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_bloc.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_event.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_state.dart';
import 'package:trikcuan_app/core/model/account_model.dart';
import 'package:trikcuan_app/pages/corporate.dart';
import 'package:trikcuan_app/pages/daftarkelas.dart';
import 'package:trikcuan_app/pages/dataperusahaan.dart';
import 'package:trikcuan_app/pages/topup_saldo.dart';
import 'package:trikcuan_app/utilities/app_consts.dart';
import 'package:trikcuan_app/utilities/styles.dart';
import 'package:intl/intl.dart';
import 'package:trikcuan_app/widget/box.dart';
import 'package:trikcuan_app/widget/button.dart';
import 'package:trikcuan_app/login_page.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  bool _crossFadeStateShowFirst = true;
  final money = NumberFormat("#,##0", "en_US");
  final nominal = TextEditingController();

  final bloc = AuthBloc();
  final accountBloc = AccountBloc();

  Account account;

  @override
  void initState() {
    accountBloc.add(GetAccount());
    super.initState();
  }

  @override
  void dispose() {
    nominal.dispose();
    super.dispose();
  }

  void _crossFade() {
    setState(() {
      _crossFadeStateShowFirst = _crossFadeStateShowFirst ? false : true;
    });
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
        ),
        BlocListener(
          cubit: accountBloc,
          listener: (context, state) {
            if(state is AccountSuccess) {
              setState(() {
                account = state.data;
              });
            }
          },
        )
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.limeAccent,
          title: Text('PROFIL', style: TextStyle(color: Colors.blueGrey[600], fontWeight: FontWeight.bold),),
          elevation: 1
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Halo,\n${account?.name}",
                    style: kTitleStyle,
                  ),
                  SizedBox(height: 16),
                  Box(
                    borderRadius: 16,
                    color: Colors.white,
                    boxShadow: [AppBoxShadow.type3],
                    child: Column(
                      children: [
                        Box(
                          padding: 16,
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Saldo',
                                  style: TextStyle(
                                    color: Colors.blueGrey[600],
                                    fontFamily: 'Poppins',
                                    fontSize: 15.0
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Container(
                                child: Text(
                                  rupiah(account?.balance),
                                  style: TextStyle(
                                    color: Colors.blueGrey[900],
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w800,
                                    fontSize: 28
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Box(
                          color: Colors.transparent,
                          padding: 16,
                          onPressed: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) => TopupSaldoPage()
                          )),
                          child: Text(
                            'Klik Disini Untuk Top Up Saldo',
                            style: TextStyle(
                              color: Colors.blueGrey[600],
                              fontFamily: 'Poppins',
                              fontSize: 15.0
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  RaisedButtonCustom(
                    color: Colors.white,
                    elevation: 1,
                    onPressed: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => DaftarKelas()
                    )),
                    textColor: Colors.black54,
                    text: "Daftar Kelas Trik Cuan"
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: RaisedButtonCustom(
                          color: Colors.white,
                          elevation: 1,
                          onPressed: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) => DataPerusahaan()
                          )),
                          textColor: Colors.black54,
                          text: "Data Perusahaan"
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: RaisedButtonCustom(
                          color: Colors.white,
                          elevation: 1,
                          onPressed: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Corporate()
                          )),
                          textColor: Colors.black54,
                          text: "Corporate Action"
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  RaisedButtonCustom(
                    color: Colors.red,
                    onPressed: () => bloc.add(Logout()),
                    elevation: 1,
                    textColor: Colors.white,
                    text: "Logout"
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _confirmPaymentModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext payment) {
        return Container(
          height: 225.0,
          width: double.infinity,
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.close, color: Colors.red[400], size: 30.0),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Text(
                '   KONFIRMASI ISI SALDO',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text('Jumlah Isi Saldo'), Text("Rp.")],
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Biaya Admin'),
                    Text('Rp.2000'),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    height: 40.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green[300], Colors.green[600]],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border:
                            Border.all(width: 2.0, color: Colors.grey.shade500),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text('ISI SALDO SEKARANG'),
                    )),
              ),
            ],
          ),
        );
      });
}
