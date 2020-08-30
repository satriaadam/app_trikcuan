import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class Trading extends StatelessWidget {
  const Trading({Key key}) : super(key: key);

  static const List<Tuple3> tradingpage = [
    const Tuple3<String, String, String>(
      'Nama Em',
      'Nama Perus',
      'Nilai',
    ),
    const Tuple3<String, String, String>(
      'Nama Emit',
      'Nama Perus',
      'Nilai',
    ),
    const Tuple3<String, String, String>(
      'Nama Emit',
      'Nama Perus',
      'Nilai',
    ),
    const Tuple3<String, String, String>(
      'Nama Emit',
      'Nama Perus',
      'Nilai',
    ),
    const Tuple3<String, String, String>(
      'Nama Emit',
      'Nama Perus',
      'Nilai',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: tradingpage.map((tradingpage) => _buildListItem(tradingpage)).toList(),
    );
  }
}

Widget _buildListItem(Tuple3 tradingpage) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(10.0),
      shadowColor: Color(0x802196F3),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: myCurrencies(
            tradingpage
          //   currencyVal,
          //   currencyPercentage,
          //   currencyStatus,
          //   colorVal
        ),
      ),
    ),
  );
}

Widget myCurrencies(Tuple3 tradingpage) {
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          myLeadingDetails(tradingpage),
          myCurrenciesDetails(tradingpage),
        ],)
    ],);
}


Widget myLeadingDetails(Tuple3 tradingpage) {
  return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              tradingpage.item1, style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 20.0
            ),
              textAlign: TextAlign.left,  ),),
          Container(
            child: Text(
              tradingpage.item2, style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 10.0
            ),
              textAlign: TextAlign.left,  ),),
        ],)
  );
}


Widget myCurrenciesDetails(Tuple3 tradingpage) {
  return Container(child: Column(
    children: <Widget>[
      Container(child: Text(
          'Potensi = ' + tradingpage.item3,
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w800,
              fontSize: 20.0
          )
      ),),
          ],)
      );
}
