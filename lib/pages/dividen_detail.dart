import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trikcuan_app/core/model/dividen_model.dart';
import 'package:trikcuan_app/utilities/app_consts.dart';
import 'package:trikcuan_app/widget/box.dart';
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DIVIDEN")
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
        ],
      ),
    );
  }
}