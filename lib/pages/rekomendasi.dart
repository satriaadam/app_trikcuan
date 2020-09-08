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
    TabBar myTabBar = TabBar(
      indicatorColor: Color(0xFFf2786b),
      indicatorWeight: 3.0,
      unselectedLabelColor: Color(0xFFFEFFFE),
      tabs: _pages
          .map<Tab>((Tuple2 page) => Tab(text: page.item1))
          .toList(),
    );

    return DefaultTabController(
      length: _pages.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          backgroundColor: Color(0xFF295c97),
            leading: Icon(Icons.arrow_back_ios, color: Color(0xFF295C97)),
          title: Text('REKOMENDASI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(myTabBar.preferredSize.height),
            child: Container(color: Color(0xFF1f4c7e), child: myTabBar,)
          )

        //  TabBar(
        //    labelColor: Colors.black54,
        //    indicatorColor: Colors.redAccent,
        //    tabs: _pages
        //        .map<Tab>((Tuple2 page) => Tab(text: page.item1))
        //        .toList(),
        //  ),
        ),
        body: TabBarView(
          children: _pages.map<Widget>((Tuple2 page) => page.item2).toList(),
        ),
      ),
    );
  }
}
