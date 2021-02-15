import 'package:flutter/material.dart';

class KonsultasiSaham extends StatefulWidget {
  @override
  _KonsultasiSahamState createState() => _KonsultasiSahamState();
}

class _KonsultasiSahamState extends State<KonsultasiSaham> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blueGrey[600],),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Konsultasi Saham', style: TextStyle(
          color: Colors.blueGrey[600],
        ),),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: Image(
            image: AssetImage(
              'assets/images/undraw_under_construction_46pa.png',
            ),
          ),
        ),
      ),
    );
  }
}
