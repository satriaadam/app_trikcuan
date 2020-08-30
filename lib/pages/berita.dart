import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class Berita extends StatelessWidget {
  const Berita({Key key}) : super(key: key);

  static const List<Tuple2> indexpage = [
    const Tuple2<String, String>(
      'DOW30',
      '27,930.33',
    ),
    const Tuple2<String, String>(
      'IHSG',
      '5,272.81',
    ),
    const Tuple2<String, String>(
      'SP500',
      '3,397.16',
    ),
    const Tuple2<String, String>(
      'NASDAQ',
      '11,311.80',
    ),
    const Tuple2<String, String>(
      'NIKKEI',
      '22,920.30',
    ),const Tuple2<String, String>(
      'HANGSENG',
      '25,113.84',
    ),const Tuple2<String, String>(
      'SHANGHAI',
      '3,380.68',
    ),const Tuple2<String, String>(
      'FTSE',
      '6,012.38',
    ),
    const Tuple2<String, String>(
      'DAX',
      '12,785.80',
    ),
    const Tuple2<String, String>(
      'CAC40',
      '4,896.33',
    ),
    const Tuple2<String, String>(
      'EIDO',
      '19.49',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView(
      children: indexpage.map((indexpage) => _buildListItem(indexpage)).toList(),
      itemExtent: 90,
      diameterRatio: 3,
    );
  }
}

Card _buildListItem(Tuple2 indexpage) {
  return Card(
    margin: const EdgeInsets.all(5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          indexpage.item1,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
              indexpage.item2,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[600],
              ),
            ),
           ],
          ),
    );
}
