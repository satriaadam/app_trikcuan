import 'package:flutter/material.dart';
import 'package:trikcuan_app/pages/berita.dart';
import 'package:trikcuan_app/pages/chart.dart';
import 'package:trikcuan_app/pages/lq45.dart';
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
        LQ45Page(),
        Rekomendasi(),
        NewsPage(),
        Profil(),
      ].elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        elevation: 5.0,
        showUnselectedLabels: true,
        selectedItemColor: Color(0xFF009eeb),
        iconSize: 30.0,
        backgroundColor: Colors.white,
        selectedFontSize: 12.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            title: Text('Market', style:TextStyle(
              fontSize: 10.0
            )),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer),
            title: Text('Saham LQ 45', style: TextStyle(
              fontSize: 10.0
            )),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.blur_on),
            title: Text('Rekomendasi', style: TextStyle(
              fontSize: 10.0
            )),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            title: Text('Berita', style: TextStyle(
              fontSize: 10.0
            )),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profil', style: TextStyle(
              fontSize: 10.0
            )),
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
