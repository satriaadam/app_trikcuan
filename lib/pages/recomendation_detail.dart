import 'package:flutter/material.dart';
import 'package:trikcuan_app/core/model/recomendation_model.dart';
import 'package:trikcuan_app/utilities/app_consts.dart';
import 'package:trikcuan_app/widget/box.dart';
import 'package:trikcuan_app/widget/text.dart';

class RecomendationDetailpage extends StatefulWidget {
  const RecomendationDetailpage({
    Key key,
    this.recomendation
  }) : super(key: key);

  final RecomendationModel recomendation;

  @override
  _RecomendationDetailpageState createState() => _RecomendationDetailpageState();
}

class _RecomendationDetailpageState extends State<RecomendationDetailpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          SubtitleText("FUndamental"),
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
        ],
      ),
    );
  }
}