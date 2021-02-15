import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trikcuan_app/core/api/market_api.dart';
import 'package:trikcuan_app/core/bloc/market/market_event.dart';
import 'package:trikcuan_app/core/bloc/market/market_state.dart';
import 'package:trikcuan_app/core/model/market_model.dart';

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final api = MarketApi();

  MarketBloc() : super(MarketUninitialized());

  @override
  Stream<MarketState> mapEventToState(MarketEvent event) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (event is LoadMarket) {
      yield MarketLoading();
      try {
        var pref = prefs.getString("market_${event.type}");
        if(pref != null) yield MarketLoaded(data: marketModelFromMap(pref));
        final response = await api.getData(event.type);
        prefs.setString("market_${event.type}", marketModelToMap(response));
        yield MarketLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield MarketFailure(error: error.toString());
      }
    }

  }
}