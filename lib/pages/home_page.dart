import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:trikcuan_app/pages/berita.dart';
import 'package:trikcuan_app/pages/chart.dart';
import 'package:trikcuan_app/pages/dividen.dart';
import 'package:trikcuan_app/pages/profil.dart';
import 'package:trikcuan_app/pages/rekomendasi.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        Chart(),
        Dividen(),
        Rekomendasi(),
        Berita(),
        Profil(),
      ].elementAt(_selectedIndex),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        items: <Widget>[
          Icon(Icons.timeline, size: 35.0, color: Colors.black54,),
          Icon(Icons.equalizer, size: 35.0, color: Colors.black54),
          Icon(Icons.blur_on, size: 45.0, color: Colors.black54),
          Icon(Icons.library_books, size: 35.0, color: Colors.black54),
          Icon(Icons.person, size: 35.0, color: Colors.black54),
        ],
        color: Colors.amberAccent,
        buttonBackgroundColor: Colors.amberAccent,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: _OnBarItemTap,
          ),
      );
  }

  // ignore: non_constant_identifier_names
  void _OnBarItemTap(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
