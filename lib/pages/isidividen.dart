import 'package:flutter/material.dart';
import 'package:trikcuan_app/pages/dividen.dart';
import 'package:tuple/tuple.dart';

class IsiDividen extends StatelessWidget {
  const IsiDividen({Key key}) : super(key: key);

  static const List<Tuple5> isidividenpage = [
    const Tuple5<String, String, String, String, String>(
      'BRIS',
      'PT. Bank Rakyat Indonesia Syariah (Tbk.)',
      'nilai',
      '26-08-20',
      '27-08-20',
    ),
    const Tuple5<String, String, String, String, String>(
      'BRIS',
      'PT. Bank Rakyat Indonesia Syariah (Tbk)',
      'nilai',
      '26-08-20',
      '27-08-20',
    ),
    const Tuple5<String, String, String, String, String>(
      'BRIS',
      'PT. Bank Rakyat Indonesia Syariah (Tbk)',
      'nilai',
      '26-08-20',
      '27-08-20',
    ),
    const Tuple5<String, String, String, String, String>(
      'BRIS',
      'PT. Bank Rakyat Indonesia Syariah (Tbk)',
      'nilai',
      '26-08-20',
      '27-08-20',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: isidividenpage.map((isidividenpage) => _buildListItem(context, isidividenpage)).toList(),
    );
  }
}

Widget _buildListItem(BuildContext context, Tuple5 isidividenpage) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(
      builder: (isidividenpage) => Dividen(),
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
            isidividenpage
        ),
      ),
    ),
    ),
  );
}

Widget myCurrencies(Tuple5 isidividenpage) {
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          myLeadingDetails(isidividenpage),
          potensi(isidividenpage),
          cumdate(isidividenpage),
          exdate(isidividenpage),
        ],)
    ],);
}


Widget myLeadingDetails(Tuple5 isidividenpage) {
  return Container(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        child: Text(
          isidividenpage.item1, style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 25.0
        ),
          textAlign: TextAlign.left,  ),),
      Container(
        child: Text(
          isidividenpage.item2, style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 10.0
        ),
          textAlign: TextAlign.left,  ),),
    ],)
  );
}


Widget potensi(Tuple5 isidividenpage) {
  return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
                'Potensi', style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 12.0
            ),
              textAlign: TextAlign.left,  ),),
          SizedBox(height: 10.0),
          Container(
            child: Text(
              isidividenpage.item3, style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 10.0
            ),
              textAlign: TextAlign.left,  ),),
        ],)
  );
}

Widget cumdate(Tuple5 isidividenpage) {
  return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              'Cumdate', style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 12.0
            ),
              textAlign: TextAlign.left,  ),),
          SizedBox(height: 10.0),
          Container(
            child: Text(
              isidividenpage.item4, style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 10.0
            ),
              textAlign: TextAlign.left,  ),),
        ],)
  );
}

Widget exdate(Tuple5 isidividenpage) {
  return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              'Exdate', style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 12.0
            ),
              textAlign: TextAlign.left,  ),),
          SizedBox(height: 10.0),
          Container(
            child: Text(
              isidividenpage.item5, style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 10.0
            ),
              textAlign: TextAlign.left,  ),),
        ],)
  );
}