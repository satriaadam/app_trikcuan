import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indonesia/indonesia.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trikcuan_app/core/bloc/account/account_bloc.dart';
import 'package:trikcuan_app/core/bloc/account/account_event.dart';
import 'package:trikcuan_app/core/bloc/account/account_state.dart';
import 'package:trikcuan_app/core/bloc/dividen/dividen_bloc.dart';
import 'package:trikcuan_app/core/bloc/dividen/dividen_event.dart';
import 'package:trikcuan_app/core/bloc/dividen/dividen_state.dart';
import 'package:trikcuan_app/core/model/account_model.dart';
import 'package:trikcuan_app/core/model/dividen_model.dart';
import 'package:trikcuan_app/utilities/app_consts.dart';
import 'package:trikcuan_app/widget/box.dart';
import 'package:trikcuan_app/widget/button.dart';
import 'package:trikcuan_app/widget/text.dart';

class DividenDetail extends StatefulWidget {
  const DividenDetail({
    Key key,
    this.dividen
  }) : super(key: key);

  final DividenModel dividen;

  @override
  _DividenDetailState createState() => _DividenDetailState();
}

class _DividenDetailState extends State<DividenDetail> {

  DateFormat formatDate = DateFormat('yyyy-MM-dd');

  final bloc = DividenBloc();
  bool isLoading = true;
  bool isOwn = false;
  bool isLoadingBuy = false;

  final accountBloc = AccountBloc();
  Account account;

  @override
  void initState() {
    bloc.add(CheckDividen(
      dataId: widget.dividen.id.toString()
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
            if(state is BuyDividenSuccess) {
              setState(() {
                isLoading = false;
                isLoadingBuy = false;
                isOwn = true;
              });
            } else if(state is DividenAvailable) {
              setState(() {
                isLoading = false;
                isLoadingBuy = false;
                isOwn = true;
              });
            } else if(state is DividenFailure) {
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
            color: Colors.black54
          ),
          title: Text("DIVIDEN", style: TextStyle(color: Colors.black54),),
          backgroundColor: Colors.amberAccent,

        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text("Pilihan Saham"),
            SizedBox(height: 16),
            Box(
              padding: 16,
              color: Colors.white,
              boxShadow: [AppBoxShadow.type3],
              borderRadius: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextCustom(
                          widget.dividen.kodeSaham,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LabelText(
                              "Potensi",
                            ),
                            TextCustom(
                              widget.dividen.potensi,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LabelText(
                              "Cumdate",
                            ),
                            TextCustom(
                              formatDate.format(widget.dividen.cumdate),
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LabelText(
                              "Ex Date",
                            ),
                            TextCustom(
                              formatDate.format(widget.dividen.exdate),
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 32),
            isLoading ? shimmerData(context) : Container(),
            !isLoading && isOwn ? ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                SubtitleText("Keuntungan"),
                SizedBox(height: 8),
                Text(widget.dividen.keterangan),
                SizedBox(height: 24),
                SubtitleText("Beli"),
                SizedBox(height: 8),
                Text(widget.dividen.beli),
                SizedBox(height: 24),
                SubtitleText("Jual"),
                SizedBox(height: 8),
                Text(widget.dividen.jual),
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
                      "Untuk mendapatkan informasi (Fundamental, Teknikal, Sentiman, dll) Anda harus menekan tombol di bawah ini terlebih dahulu", 
                      textAlign: TextAlign.center
                    ),
                    SizedBox(height: 16),
                    RaisedButtonPrimary(
                      isLoading: isLoadingBuy,
                      onPressed: isLoadingBuy || int.parse(account?.balance) < widget.dividen.price ? null : () {
                        setState(() {
                          isLoadingBuy = true;
                          bloc.add(BuyDividen(
                            dataId: widget.dividen.id.toString(),
                            price: widget.dividen.price
                          ));
                        });
                      },
                      text: "Beli ${rupiah(widget.dividen.price)}",
                    ),
                    SizedBox(height: 16),
                    int.parse(account?.balance) < widget.dividen.price ? TextCustom("Saldo Anda ${rupiah(account?.balance)} tidak cukup", color: Colors.red, textAlign: TextAlign.center) : Text("")
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