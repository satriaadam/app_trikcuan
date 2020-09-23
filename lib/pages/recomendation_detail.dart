import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indonesia/indonesia.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trikcuan_app/core/bloc/account/account_bloc.dart';
import 'package:trikcuan_app/core/bloc/account/account_event.dart';
import 'package:trikcuan_app/core/bloc/account/account_state.dart';
import 'package:trikcuan_app/core/bloc/recomendation/recomendation_bloc.dart';
import 'package:trikcuan_app/core/bloc/recomendation/recomendation_event.dart';
import 'package:trikcuan_app/core/bloc/recomendation/recomendation_state.dart';
import 'package:trikcuan_app/core/model/account_model.dart';
import 'package:trikcuan_app/core/model/recomendation_model.dart';
import 'package:trikcuan_app/utilities/app_consts.dart';
import 'package:trikcuan_app/widget/box.dart';
import 'package:trikcuan_app/widget/button.dart';
import 'package:trikcuan_app/widget/dialog.dart';
import 'package:trikcuan_app/widget/text.dart';

class RecomendationDetailpage extends StatefulWidget {
  const RecomendationDetailpage({
    Key key,
    this.recomendation,
    this.type,
  }) : super(key: key);

  final RecomendationModel recomendation;
  final String type;

  @override
  _RecomendationDetailpageState createState() => _RecomendationDetailpageState();
}

class _RecomendationDetailpageState extends State<RecomendationDetailpage> {

  DateFormat formatDate = DateFormat('yyyy-MM-dd');

  final bloc = RecomendationBloc();
  bool isLoading = true;
  bool isOwn = false;
  bool isLoadingBuy = false;

  final accountBloc = AccountBloc();
  Account account;

  @override
  void initState() {
    bloc.add(CheckRecomendationData(
      dataId: widget.recomendation.id.toString(),
      recomendation: widget.type,
      date: formatDate.format(DateTime.now())
    ));
    accountBloc.add(GetAccount());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          cubit: bloc,
          listener: (context, state) {
            if(state is RecomendationDataAvailable) {
              setState(() {
                isLoading = false;
                isOwn = true;
              });
            } else if(state is RecomendationTodayLoaded) {
              setState(() {
                isLoading = false;
                isOwn = true;
              });
            } else if(state is RecomendationFailure) {
              setState(() {
                isLoading = false;
                isLoadingBuy = false;
                isOwn = false;
              });
            }
          }
        ),
        BlocListener(
          cubit: accountBloc,
          listener: (context, state) {
            if(state is AccountSuccess) {
              setState(() {
                account = state.data;
              });
            }
          }
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white
          ),
          elevation: 1,
          backgroundColor: Color(0xFF009eeb),
          title: Text('DETAIL INFO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text("Pilihan Saham"),
            SizedBox(height: 16),
            Box(
              padding: 16,
              boxShadow: [AppBoxShadow.type3],
              borderRadius: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(widget.recomendation.kodeSaham),
                  SizedBox(height: 16),
                  Divider(),
                  SizedBox(height: 16),
                  TextCustom(
                    "POTENSI: \n${widget.recomendation.potensiKenaikan}",
                    maxLines: 10,
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            isLoading ? shimmerData(context) : Container(),
            !isLoading && isOwn ? ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                SizedBox(height: 32),
                SubtitleText("Prospek Perusahaan"),
                SizedBox(height: 8),
                Text(widget?.recomendation?.prospekPerusahaan ?? ""),
                SizedBox(height: 24),
                SubtitleText("Fundamental"),
                SizedBox(height: 8),
                Text(widget?.recomendation?.fundamental ?? ""),
                SizedBox(height: 24),
                SubtitleText("Teknikal"),
                SizedBox(height: 8),
                Text(widget?.recomendation?.teknikal ?? ""),
                SizedBox(height: 24),
                SubtitleText("Jual Beli"),
                SizedBox(height: 8),
                Text(widget?.recomendation?.jualBeli ?? ""),
              ]
            ) : Container(),
            !isOwn && !isLoading ? Container(
              child: Box(
                padding: 16,
                borderRadius: 8,
                borderColor: Colors.grey[300],
                child: ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: [
                    Text(
                      "Untuk mendapatkan info harga jual dan beli, silahkan tekan tombol di bawah ini",
                      textAlign: TextAlign.center
                    ),
                    SizedBox(height: 16),
                    RaisedButtonSecondary(
                      isLoading: isLoadingBuy,
                      onPressed: isLoadingBuy || int.parse(account?.balance ?? "0") < int.parse(widget.recomendation?.hargaBeli ?? "0") ? null 
                      : () => dialogConfirmation(
                        context: context,
                        message: "Untuk mengakses fitur ini saldo Anda akan dipotong sebesar ${rupiah(int.parse(widget.recomendation.hargaBeli))}",
                        textCancel: "Batal",
                        textConfirm: "OK",
                        callback: () {
                          Navigator.pop(context);
                          setState(() {
                            isLoadingBuy = true;
                            bloc.add(BuyRecomendation(
                              recomendation: widget.type,
                              type: "recomendation-data",
                              dataId: widget.recomendation.id.toString(),
                              price: int.parse(widget.recomendation.hargaBeli)
                            ));
                          });
                        }
                      ),
                      text: "Beli ${rupiah(int.parse(widget.recomendation?.hargaBeli ?? '0'))}",
                    ),
                    int.parse(account?.balance) < int.parse(widget.recomendation?.hargaBeli ?? "0") ? Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: TextCustom("Saldo Anda tidak mencukupi, silahkan Top Up saldo Anda", color: Colors.red, textAlign: TextAlign.center),
                    ) : Text("")
                  ],
                ),
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }

  Shimmer shimmerData(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Box(
              width: MediaQuery.of(context).size.width,
              height: 8,
              borderRadius: 8
            ),
          ],
        ),
      ),
    );
  }
  
}