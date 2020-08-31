import 'package:flutter/material.dart';
import 'package:trikcuan_app/pages/rekomendasi.dart';
import 'package:tuple/tuple.dart';

class Swing extends StatelessWidget {
  const Swing({Key key}) : super(key: key);

  static const List<Tuple3> swingpage = [
    const Tuple3<String, String, String>(
      'Nama Emit',
      'Nama Perusahaan',
      'Nilai',
    ),
    const Tuple3<String, String, String>(
      'Nama Emit',
      'Nama Perusahaan',
      'Nilai',
    ),
    const Tuple3<String, String, String>(
      'Nama Emit',
      'Nama Perusahaan',
      'Nilai',
    ),
    const Tuple3<String, String, String>(
      'Nama Emit',
      'Nama Perusahaan',
      'Nilai',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: swingpage.map((swingpage) => _buildListItem(context, swingpage)).toList(),
    );
  }
}

Widget _buildListItem(BuildContext context, Tuple3 swingpage) {
  return GestureDetector(
      onTap: () {
    Navigator.push(context, MaterialPageRoute(
      builder: (swingpage) => Rekomendasi(),
    ));
  },
    child: Container(
    padding: const EdgeInsets.all(5.0),
    child: Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(10.0),
      shadowColor: Color(0x802196F3),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: myCurrencies(
            swingpage
          //   currencyVal,
          //   currencyPercentage,
          //   currencyStatus,
          //   colorVal
        ),
      ),
    ),
    ),
  );
}

Widget myCurrencies(Tuple3 swingpage) {
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          myLeadingDetails(swingpage),
          myCurrenciesDetails(swingpage),
        ],)
    ],);
}


Widget myLeadingDetails(Tuple3 swingpage) {
  return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              swingpage.item1, style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 20.0
            ),
              textAlign: TextAlign.left,  ),),
          Container(
            child: Text(
              swingpage.item2, style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 10.0
            ),
              textAlign: TextAlign.left,  ),),
        ],)
  );
}


Widget myCurrenciesDetails(Tuple3 swingpage) {
  return Container(child: Column(
    children: <Widget>[
      Container(child: Text(
          'Potensi = ' + swingpage.item3,
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w800,
              fontSize: 20.0
          )
      ),),
          ],),
      );
}
