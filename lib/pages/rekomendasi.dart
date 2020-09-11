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
      indicatorColor: Color(0xFF009eec),
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
          centerTitle: true,
          bottomOpacity: 0.8,
          backgroundColor: Color(0xFF009eeb),
            leading: Icon(Icons.arrow_back_ios, color: Color(0xFF009eeb)),
          title: Text('REKOMENDASI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(myTabBar.preferredSize.height),
            child: Container(color: Color(0xFF48d25f), child: myTabBar,)
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
