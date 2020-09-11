import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indonesia/indonesia.dart';
import 'package:toast/toast.dart';
import 'package:trikcuan_app/core/bloc/account/account_bloc.dart';
import 'package:trikcuan_app/core/bloc/account/account_event.dart';
import 'package:trikcuan_app/core/bloc/account/account_state.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_bloc.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_event.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_state.dart';
import 'package:trikcuan_app/core/model/account_model.dart';
import 'package:trikcuan_app/pages/topup_saldo.dart';
import 'package:trikcuan_app/utilities/app_consts.dart';
import 'package:intl/intl.dart';
import 'package:trikcuan_app/widget/box.dart';
import 'package:trikcuan_app/widget/button.dart';
import 'package:trikcuan_app/login_page.dart';
import 'package:trikcuan_app/widget/dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final money = NumberFormat("#,##0", "en_US");
  final nominal = TextEditingController();

  final bloc = AuthBloc();
  final accountBloc = AccountBloc();

  Account account;
  bool isLoadingConsultation = false;

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
            else if(state is BuyConsultationSuccess) {
              setState(() {
                account = state.data;
                isLoadingConsultation = false;
              });
              var desc = "Semangat pagi Mbah Giso, saya\n\n";
              desc += "nama: ${account.name}\n";
              desc += "username: ${account.username}\n\n";
              desc += "Mau bertanya\n\n";
              desc += "<PERTANYAAN_ANDA_DISINI>";
              launchURL("https://api.whatsapp.com/send?phone=${account?.contactPerson}&text=$desc");
            }
            else if(state is AccountFailure) {
              Toast.show(state.error, context);
              setState(() {
                isLoadingConsultation = false;
              });
            }
          },
        )
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Color(0xFF009eeb),
          leading: Icon(Icons.arrow_back_ios, color: Color(0xFF009eeb)),
          title: Text('PROFIL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          centerTitle: true,
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
                    "Halo,",
                    style: TextStyle(
                      fontFamily: 'CM Sans Serif',
                      height: 1.5,
                     // fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black54
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "${account?.name}",
                    style: TextStyle(
                        fontFamily: 'CM Sans Serif',
                        height: 1.5,
                       // fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        color: Colors.black54
                    ),
                  ),
                  SizedBox(height: 16),
                  Box(
                    borderRadius: 16,
                    borderColor: Color(0xFF009eeb),
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
                                    color: Colors.black54,
                                    fontFamily: 'Monserrat',
                                    fontSize: 15.0
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Container(
                                child: Text(
                                  rupiah(account?.balance),
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: 'Monserrat',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Color(0xFF009eeb), thickness: 1,),
                        Box(
                          color: Colors.transparent,
                          padding: 16,
                          onPressed: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) => TopupSaldoPage()
                          )),
                          child: Text(
                            'Klik Disini Untuk Top Up Saldo',
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Monserrat',
                              fontSize: 14.0
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
                    elevation: 2,
                    onPressed: () {
                      launchURL("https://api.whatsapp.com/send?phone=${account?.contactPerson}");
                    },
                    textColor: Colors.black54,
                    text: "Daftar Kelas Trik Cuan"
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButtonCustom(
                        color: Colors.white,
                        elevation: 2,
                        isLoading: isLoadingConsultation,
                        onPressed: () {
                          if(account.consultation) {
                            var desc = "Semangat pagi Mbah Giso, saya\n\n";
                            desc += "nama: ${account.name}\n";
                            desc += "username: ${account.username}\n\n";
                            desc += "Mau bertanya\n\n";
                            desc += "<PERTANYAAN_ANDA_DISINI>";
                            launchURL("https://api.whatsapp.com/send?phone=${account?.contactPerson}&text=$desc");
                          } else {
                            dialogConfirmation(
                              context: context,
                              message: int.parse(account?.balance) < account?.consultationPrice ? "Saldo Anda tidak mencukupi. Untuk mengakses fitur ini dikenakan potongan sebesar ${rupiah(account?.consultationPrice)}" : "Untuk mengakses fitur ini dikenakan potongan sebesar ${rupiah(account?.consultationPrice)}, apakah Anda setuju?",
                              textCancel: "Batal",
                              textConfirm: int.parse(account?.balance) < account?.consultationPrice ? "Isi Saldo" : "OK",
                              callback: () {
                                Navigator.pop(context);
                                if(int.parse(account?.balance) < account?.consultationPrice) {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => TopupSaldoPage()
                                  ));
                                } else {
                                  accountBloc.add(BuyConsultation());
                                  setState(() {
                                    isLoadingConsultation = true;
                                  });
                                }
                              }
                            );
                          }
                        },
                        textColor: Colors.black54,
                        text: "Konsultasi Saham Mbah Giso"
                    ),
                  ),
                  SizedBox(height: 16),
                  RaisedButtonCustomSecondary(
                    color: Color(0xFFf05d59),
                    onPressed: () => bloc.add(Logout()),
                    elevation: 2,
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

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}