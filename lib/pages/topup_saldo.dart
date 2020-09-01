import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indonesia/indonesia.dart';
import 'package:toast/toast.dart';
import 'package:trikcuan_app/core/bloc/account/account_bloc.dart';
import 'package:trikcuan_app/core/bloc/account/account_event.dart';
import 'package:trikcuan_app/core/bloc/account/account_state.dart';
import 'package:trikcuan_app/core/model/topup_model.dart';
import 'package:trikcuan_app/utilities/app_consts.dart';
import 'package:trikcuan_app/widget/box.dart';
import 'package:trikcuan_app/widget/button.dart';
import 'package:trikcuan_app/widget/text.dart';
import 'package:url_launcher/url_launcher.dart';

class TopupSaldoPage extends StatefulWidget {
  @override
  _TopupSaldoPageState createState() => _TopupSaldoPageState();
}

class _TopupSaldoPageState extends State<TopupSaldoPage> {

  List<int> listSaldo = [10000, 20000, 50000, 100000, 200000];
  int saldoSelected;
  bool showConfirmationPayment = false;
  bool isLoading = false;
  TopupModel topup;
  final bloc = AccountBloc();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if(state is RequestTopupSaldoSuccess) {
          setState(() {
            isLoading = false;
            showConfirmationPayment = true;
            topup = state.data;
          });
        } else if(state is AccountFailure) {
          Toast.show(state.error, context);
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Top Up Saldo")
        ),
        body: showConfirmationPayment ? Container(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              TitleText("Petunjuk Pembayaran"),
              SizedBox(height: 16),
              Box(
                borderRadius: 8,
                borderColor: Colors.grey[300],
                child: ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: [
                    Box(
                      color: Colors.transparent,
                      padding: 16,
                      child: Text("Transfer ke Nomor Gopay ${topup?.transferTo}")
                    ),
                    Divider(),
                    Box(
                      color: Colors.transparent,
                      padding: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nominal"),
                          SubtitleText(rupiah(topup?.balance)),
                        ],
                      )
                    ),
                    Divider(),
                    Box(
                      color: Colors.transparent,
                      padding: 16,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Setelah transfer, mohon konfirmasi ke No Whatsapp di bawah ini"),
                                SubtitleText(topup?.whatsapp ?? ""),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.link), 
                            onPressed: () => launchURL("https://api.whatsapp.com/send?phone=${topup?.whatsapp}")
                          )
                        ],
                      )
                    ),
                  ],
                )
              )
            ],
          ),
        ) : ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextCustom("Pilih Nominal Saldo", fontSize: 16),
            SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              separatorBuilder: (context, index) => Divider(),
              itemCount: listSaldo.length,
              itemBuilder: (context, index) => Box(
                onPressed: () => setState(() => saldoSelected = listSaldo[index]),
                boxShadow: [AppBoxShadow.type3],
                borderRadius: 8,
                child: Box(
                  padding: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitleText(rupiah(listSaldo[index])),
                      Icon(Icons.check_circle, color: saldoSelected == listSaldo[index] ? Colors.green : Colors.transparent)
                    ],
                  )
                )
              ),
            )
          ],
        ),
        bottomNavigationBar: showConfirmationPayment ? Container(height: 0) : BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButtonPrimary(
              isLoading: isLoading,
              onPressed: saldoSelected != null && !isLoading ? (){
                final random = Random();
                print(random.nextInt(999));
                bloc.add(RequestTopupSaldo(saldo: saldoSelected + random.nextInt(999)));
                setState(() {
                  isLoading = true;
                });
              } : null,
              text: saldoSelected != null ? "TOP UP ${rupiah(saldoSelected)}" : "TOP UP"
            ),
          )
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