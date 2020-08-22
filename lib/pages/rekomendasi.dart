import 'package:flutter/material.dart';

class Rekomendasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: choices.length,
          child: Scaffold(
            appBar: AppBar(
              leading: Icon(
                Icons.menu, color: Colors.blueGrey[600],
              ),
              backgroundColor: Colors.limeAccent,
              title: Text('Rekomendasi',
                style: TextStyle(
                  color: Colors.blueGrey[600],
                ),
              ),
              bottom: TabBar(
                tabs: choices.map<Widget>((Choice choice) {
                  return Tab(
                    text: choice.title,
                    icon: Icon(choice.icon),
                  );
                }).toList(),
              ),
            ),
            body: TabBarView(
              children: choices.map((Choice choice) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ChoicePage(
                    choice: choice,
                  ),
                );
              }).toList(),
            ),
          )
      ),
    );
  }
}

class Choice{
  final String title;
  final IconData icon;
  const Choice({this.title, this.icon});
}

const List<Choice> choices = <Choice>[
  Choice(title: 'INDEX', icon: Icons.trending_up),
  Choice(title: 'KOMODITAS', icon: Icons.attach_money),
];

class ChoicePage extends StatelessWidget{
  const ChoicePage({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(choice.icon,
                size: 125.0,
                color: textStyle.color,
              ),
              Text(choice.title,
                style: textStyle,
              ),
            ],
          )
      ),
    );
  }
}