import 'package:flutter/material.dart';
import 'package:trikcuan_app/pages/home_page.dart';

class Corporate extends StatefulWidget {
  @override
  _CorporateState createState() => _CorporateState();
}

class _CorporateState extends State<Corporate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blueGrey[600],),
          onPressed: () {
            Navigator.push(context, new MaterialPageRoute(
                builder: (context) => HomePage())
            );},
        ),
        title: Text('Corporate Action', style: TextStyle(
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
