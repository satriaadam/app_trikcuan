import 'package:flutter/material.dart';
import 'package:trikcuan_app/pages/index.dart';
import 'package:trikcuan_app/pages/komoditas.dart';
import 'package:tuple/tuple.dart';

class Chart extends StatefulWidget {
  Chart({Key key}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  final List<Tuple2> _pages = [
    Tuple2('INDEX', Index()),
    Tuple2('KOMODITAS', Komoditas()),
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
        title: Text('MARKET', style: TextStyle(color: Colors.blueGrey[600], fontWeight: FontWeight.bold),),
        bottom: TabBar(
          indicatorColor: Colors.blueGrey[600],
          labelColor: Colors.blueGrey[600],
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
