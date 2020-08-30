import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class Index extends StatelessWidget {
  const Index({Key key}) : super(key: key);

  static const List<Tuple5> indexpage = [
    const Tuple5<String, String, String, String, String>(
      'DOW30',
      'Dow Jones Industrial Average| America',
      '28,248.44',
      '-60.02',
      '(-0.21%)',
    ),
    const Tuple5<String, String, String, String, String>(
      'IHSG',
      'Index Harga Saham Gabungan| Indonesia',
      '5,332.53',
      '-6.36',
      '(-0.12%)',
    ),
    const Tuple5<String, String, String, String, String>(
      'SP500',
      'S&P500| USA',
      '3,443.62',
      '+12.34',
      '(+0.36%)',

    ),
    const Tuple5<String, String, String, String, String>(
      'NASDAQ',
      'Nasdaq| USA',
      '11,466.47',
      '+86.75',
      '(+0.76%)',
    ),
    const Tuple5<String, String, String, String, String>(
      'NIKKEI',
      'NIkkei| Japan',
      '23,252.00',
      '-44.77',
      '(-0.19%)'
    ),
    const Tuple5<String, String, String, String, String>(
      'HANGSENG',
      'Hang Seng|',
      '25,449.67',
      '-36.55',
      '(-0.14%)',
    ),
    const Tuple5<String, String, String, String, String>(
      'SHANGHAI',
      'Shanghai Composite| China',
      '3,337.03',
      '-36.55',
      '(-1.08%)',
    ),
    const Tuple5<String, String, String, String, String>(
      'FTSE',
      'FTSE 100|',
      '6,037.01',
      '-67.72',
      '(-1.11%)',
    ),
    const Tuple5<String, String, String, String, String>(
      'DAX',
      'DAX| German',
      '13,061.62',
      '-4.92',
      '(-0.04%)',
    ),
    const Tuple5<String, String, String, String, String>(
      'CAC40',
      'CAC40 Index|',
      '5,008.27',
      '+0.38',
      '(+0.01%)',
    ),
    const Tuple5<String, String, String, String, String>(
      'EIDO',
      'iShares MSCI| Indonesia',
      '20.24',
      '+0.49',
      '(+2.48%)',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
            children: indexpage.map((indexpage) => _buildListItem(indexpage)).toList(),
          );
  }
}

Widget _buildListItem(Tuple5 indexpage) {
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
            indexpage
     ),
      ),
    ),
  );
}

Widget myCurrencies(Tuple5 indexpage) {
  return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              myLeadingDetails(indexpage),
              myCurrenciesDetails(indexpage),
            ],)
        ],);
}


Widget myLeadingDetails(Tuple5 indexpage) {
  return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Container(
          child: Text(
        indexpage.item1, style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20.0
        ),
        textAlign: TextAlign.left,  ),),
        Container(
          child: Text(
          indexpage.item2, style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 10.0
        ),
        textAlign: TextAlign.left,  ),),
      ],)
  );
}


Widget myCurrenciesDetails(Tuple5 indexpage) {
  return Container(child: Column(
    children: <Widget>[
      Container(child: Text(
          indexpage.item3,
          style: TextStyle(
              color: Colors.green,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w800,
              fontSize: 20.0
          )
      ),),
      Container(child: Text(
          indexpage.item4 + indexpage.item5,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          )
      ),),
    ],
  ));
}
