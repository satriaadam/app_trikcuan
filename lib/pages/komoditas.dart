import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class Komoditas extends StatelessWidget {
  const Komoditas({Key key}) : super(key: key);

  static const List<Tuple5> komoditaspage = [
    const Tuple5<String, String, String, String, String>(
      'OIL',
      'Crude Oil',
      '43.34',
      '-0.01',
      '(-0.02%)',
    ),
    const Tuple5<String, String, String, String, String>(
      'BRENT',
      'Brent Oil',
      '46.40',
      '+0.11',
      '(+0.24%)',
    ),
    const Tuple5<String, String, String, String, String>(
      'CPO',
      'Palm Oil',
      '2,770.00',
      '-28.00',
      '(+1.00%)',

    ),
    const Tuple5<String, String, String, String, String>(
      'GAS',
      'Natural Gas',
      '2.58',
      '+0.01',
      '(+0.23%)',
    ),
    const Tuple5<String, String, String, String, String>(
        'XAU',
        'Gold',
        '1,931.85',
        '-8.75',
        '(+0.45%)'
    ),
    const Tuple5<String, String, String, String, String>(
      'SILVER',
      'Silver',
      '26.45',
      '+0.18',
      '(+0.67%)',
    ),
    const Tuple5<String, String, String, String, String>(
      'NICKEL',
      'Nickel',
      '15,055.00',
      '+57.50',
      '(+0.38%)',
    ),
    const Tuple5<String, String, String, String, String>(
      'COPPER',
      'Copper',
      '6,545.25',
      '+9.75',
      '(+0.15%)',
    ),
    const Tuple5<String, String, String, String, String>(
      'TIN',
      'Tin',
      '17,457.50',
      '-57.50',
      '(+0.33%)',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: komoditaspage.map((komoditaspage) => _buildListItem(komoditaspage)).toList(),
    );
  }
}

Widget _buildListItem(Tuple5 komoditaspage) {
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
            komoditaspage
          //   currencyVal,
          //   currencyPercentage,
          //   currencyStatus,
          //   colorVal
        ),
      ),
    ),
  );
}

Widget myCurrencies(Tuple5 komoditaspage) {
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          myLeadingDetails(komoditaspage),
          myCurrenciesDetails(komoditaspage),
        ],)
    ],);
}


Widget myLeadingDetails(Tuple5 komoditaspage) {
  return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              komoditaspage.item1, style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 20.0
            ),
              textAlign: TextAlign.left,  ),),
          Container(
            child: Text(
              komoditaspage.item2, style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 10.0
            ),
              textAlign: TextAlign.left,  ),),
        ],)
  );
}


Widget myCurrenciesDetails(Tuple5 komoditaspage) {
  return Container(child: Column(
    children: <Widget>[
      Container(child: Text(
          komoditaspage.item3,
          style: TextStyle(
              color: Colors.green,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w800,
              fontSize: 20.0
          )
      ),),
      Container(child: Text(
          komoditaspage.item4 + komoditaspage.item5,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          )
      ),),
    ],
  ));
}
