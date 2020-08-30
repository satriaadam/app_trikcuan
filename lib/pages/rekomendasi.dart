import 'package:flutter/material.dart';
import 'package:trikcuan_app/pages/trading.dart';
import 'package:trikcuan_app/pages/swing.dart';
import 'package:trikcuan_app/pages/investing.dart';
import 'package:tuple/tuple.dart';

class Rekomendasi extends StatefulWidget {
  Rekomendasi({Key key}) : super(key: key);

  @override
  _RekomendasiState createState() => _RekomendasiState();
}

class _RekomendasiState extends State<Rekomendasi> {
  final List<Tuple2> _pages = [
    Tuple2('TRADING', Trading()),
    Tuple2('SWING', Swing()),
    Tuple2('INVESTING', Investing()),
  ];



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _pages.length,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.blueGrey[600],),
          onPressed: () {},
          ),
          backgroundColor: Colors.limeAccent,
          title: Text('REKOMENDASI', style: TextStyle(color: Colors.blueGrey[600], fontWeight: FontWeight.bold),),
          bottom: TabBar(
            labelColor: Colors.blueGrey[600],
            indicatorColor: Colors.blueGrey[600],
            tabs: _pages
                .map<Tab>((Tuple2 page) => Tab(text: page.item1))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: _pages.map<Widget>((Tuple2 page) => page.item2).toList(),
        ),
      ),
    );
  }
}
