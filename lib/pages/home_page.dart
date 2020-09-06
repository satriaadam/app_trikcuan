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
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black26,
        selectedItemColor: Colors.black54,
        iconSize: 35.0,
        unselectedFontSize: 12.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            title: Text('Market'),
            backgroundColor: Colors.amberAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer),
            title: Text('Dividen'),
            backgroundColor: Colors.amberAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.blur_on),
            title: Text('Rekomendasi'),
            backgroundColor: Colors.amberAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            title: Text('Berita'),
            backgroundColor: Colors.amberAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profil'),
            backgroundColor: Colors.amberAccent,
          ),
        ],
        currentIndex: _selectedIndex,
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
