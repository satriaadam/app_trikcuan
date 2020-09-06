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
      indicatorColor: Colors.red[800],
      indicatorWeight: 3.0,
      labelColor: Colors.white,
      tabs: _pages
          .map<Tab>((Tuple2 page) => Tab(text: page.item1))
          .toList(),
    );

    return DefaultTabController(
      length: _pages.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          backgroundColor: Colors.lightBlue[900],
          leading: Image.asset('assets/images/logombahgiso.png',width: MediaQuery.of(context).size.width*0.5),
          title: Text('REKOMENDASI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(myTabBar.preferredSize.height),
            child: Container(color: Color(0xFF243E65), child: myTabBar,)
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
