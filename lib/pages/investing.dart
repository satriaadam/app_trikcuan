import 'package:flutter/material.dart';
import 'package:trikcuan_app/pages/rekomendasi.dart';
import 'package:tuple/tuple.dart';

class Investing extends StatelessWidget {
  const Investing({Key key}) : super(key: key);

  static const List<Tuple3> investingpage = [
    const Tuple3<String, String, String>(
      'BRIS',
      'PT. Bank Rakyat Indonesia Syariah (Tbk.)',
      'Nilai',
    ),
    const Tuple3<String, String, String>(
      'Nama Emiten',
      'Nama Perusahaan',
      'Nilai',
    ),
    const Tuple3<String, String, String>(
      'Nama Emiten',
      'Nama Perusahaan',
      'Nilai',
    ),
    const Tuple3<String, String, String>(
      'Nama Emiten',
      'Nama Perusahaan',
      'Nilai',
    ),
    const Tuple3<String, String, String>(
      'Nama Emiten',
      'Nama Perusahaan',
      'Nilai',
    ),
    const Tuple3<String, String, String>(
      'Nama Emiten',
      'Nama Perusahaan',
      'Nilai',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: investingpage.map((investingpage) => _buildListItem(context, investingpage)).toList(),
    );
  }
}

Widget _buildListItem(BuildContext context, Tuple3 investingpage) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(
        builder: (investingpage) => Rekomendasi(),
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
            investingpage
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

Widget myCurrencies(Tuple3 investingpage) {
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          myLeadingDetails(investingpage),
          myCurrenciesDetails(investingpage),
        ],)
    ],);
}


Widget myLeadingDetails(Tuple3 investingpage) {
  return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              investingpage.item1, style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 20.0
            ),
              textAlign: TextAlign.left,  ),),
          Container(
            child: Text(
              investingpage.item2, style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 10.0
            ),
              textAlign: TextAlign.left,  ),),
        ],)
  );
}


Widget myCurrenciesDetails(Tuple3 investingpage) {
  return Container(child: Column(
    children: <Widget>[
      Container(child: Text(
          'Potensi = ' + investingpage.item3 ,
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w800,
              fontSize: 20.0
          ),
      ),),
      ],),);
}
