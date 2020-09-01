import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trikcuan_app/core/bloc/recomendation/recomendation_bloc.dart';
import 'package:trikcuan_app/core/bloc/recomendation/recomendation_event.dart';
import 'package:trikcuan_app/core/bloc/recomendation/recomendation_state.dart';
import 'package:trikcuan_app/core/model/recomendation_model.dart';
import 'package:trikcuan_app/pages/rekomendasi.dart';
import 'package:trikcuan_app/widget/box.dart';
import 'package:trikcuan_app/widget/text.dart';
import 'package:tuple/tuple.dart';

class Trading extends StatefulWidget {
  const Trading({Key key}) : super(key: key);

  @override
  _TradingState createState() => _TradingState();
}

class _TradingState extends State<Trading> {

  List<RecomendationModel> data = <RecomendationModel>[];
  final bloc = RecomendationBloc();

  @override
  void initState() {
    bloc.add(LoadRecomendationTrading());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if(state is RecomendationTradingLoaded) {
          setState(() {
            data = state.data;
          });
        }
      },
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(), 
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Box(
            padding: 16,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextCustom(
                  data[index].kodeSaham,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmallText("Potensi"),
                    TextCustom(
                      data[index].potensiKenaikan,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ],
                ),
              ],
            ),
          );
        }, 
      )
    );
  }
}

Widget _buildListItem(BuildContext context, Tuple3 tradingpage) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (tradingpage) => Rekomendasi(),
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
          child: myCurrencies(tradingpage
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

Widget myCurrencies(Tuple3 tradingpage) {
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          myLeadingDetails(tradingpage),
          myCurrenciesDetails(tradingpage),
        ],
      )
    ],
  );
}

Widget myLeadingDetails(Tuple3 tradingpage) {
  return Container(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        child: Text(
          tradingpage.item1,
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 20.0),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        child: Text(
          tradingpage.item2,
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 10.0),
          textAlign: TextAlign.left,
        ),
      ),
    ],
  ));
}

Widget myCurrenciesDetails(Tuple3 tradingpage) {
  return Container(
    child: Column(
      children: <Widget>[
        Container(
          child: Text('Potensi = ' + tradingpage.item3,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w800,
              fontSize: 20.0
            )
          ),
        ),
      ],
    )
  );
}
