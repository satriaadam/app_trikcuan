import 'package:flutter/material.dart';
import 'package:trikcuan_app/pages/isidividen.dart';
import 'package:tuple/tuple.dart';

class Dividen extends StatefulWidget {
  Dividen({Key key}) : super(key: key);

  @override
  _DividenState createState() => _DividenState();
}

class _DividenState extends State<Dividen> {
  final List<Tuple2> _pages = [
    Tuple2('Dividen', IsiDividen()),
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
          title: Text('DIVIDEN', style: TextStyle(color: Colors.blueGrey[600], fontWeight: FontWeight.bold),),
        ),
        body: TabBarView(
          children: _pages.map<Widget>((Tuple2 page) => page.item2).toList(),
        ),
      ),
    );
  }
}
