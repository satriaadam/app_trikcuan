import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indonesia/indonesia.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trikcuan_app/core/bloc/recomendation/recomendation_bloc.dart';
import 'package:trikcuan_app/core/bloc/recomendation/recomendation_event.dart';
import 'package:trikcuan_app/core/bloc/recomendation/recomendation_state.dart';
import 'package:trikcuan_app/core/model/recomendation_model.dart';
import 'package:trikcuan_app/utilities/app_consts.dart';
import 'package:trikcuan_app/widget/box.dart';
import 'package:trikcuan_app/widget/button.dart';
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

  final bloc = RecomendationBloc();
  bool isLoading = true;
  bool isOwn = false;
  bool isLoadingBuy = false;

  @override
  void initState() {
    bloc.add(CheckRecomendationData(
      dataId: widget.recomendation.id.toString(),
      recomendation: widget.type,
      date: "2020-09-05"
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
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
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.blueGrey[600]
          ),
          elevation: 1,
          backgroundColor: Colors.limeAccent,
          title: Text('REKOMENDASI', style: TextStyle(color: Colors.blueGrey[600], fontWeight: FontWeight.bold),),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleText(widget.recomendation.kodeSaham),
                  BoldText("Potensi: ${widget.recomendation.potensiKenaikan}"),
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
                SubtitleText("Fundamental"),
                SizedBox(height: 8),
                Text(widget.recomendation.fundamental),
                SizedBox(height: 24),
                SubtitleText("Teknikal"),
                SizedBox(height: 8),
                Text(widget.recomendation.teknikal),
                SizedBox(height: 24),
                SubtitleText("Sentimen"),
                SizedBox(height: 8),
                Text(widget.recomendation.sentimen),
                SizedBox(height: 24),
                SubtitleText("Beli"),
                SizedBox(height: 8),
                Text(widget.recomendation.beli),
                SizedBox(height: 24),
                SubtitleText("Jual"),
                SizedBox(height: 8),
                Text(widget.recomendation.jual),
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
                      onPressed: isLoadingBuy ? null : () {
                        setState(() {
                          isLoadingBuy = true;
                          bloc.add(BuyRecomendation(
                            recomendation: widget.type,
                            type: "recomendation-data",
                            dataId: widget.recomendation.id.toString()
                          ));
                        });
                      },
                      text: "Beli ${rupiah(widget.recomendation.hargaBeli)}",
                    )
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