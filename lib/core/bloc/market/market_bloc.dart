import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trikcuan_app/core/api/market_api.dart';
import 'package:trikcuan_app/core/bloc/market/market_event.dart';
import 'package:trikcuan_app/core/bloc/market/market_state.dart';
import 'package:trikcuan_app/core/model/market_price_model.dart';
import 'package:trikcuan_app/core/model/market_today.dart';

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final api = MarketApi();

  MarketBloc() : super(MarketUninitialized());

  @override
  Stream<MarketState> mapEventToState(
      MarketEvent event,
      ) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (event is LoadMarketPrice) {
      yield MarketLoading();
      try {
        String json = prefs.getString("marketPrice");
        if(json != null) {
          var account = marketPriceModelFromMap(json);
          yield MarketPriceLoaded(data: account);
        }
        final response = await api.getPrices();
        if(response != null) {
          prefs.setString("marketPrice", marketPriceModelToMap(response));
          yield MarketPriceLoaded(data: response);
        }
      } catch (error) {
        print("ERROR: $error");
        yield MarketFailure(error: error.toString());
      }
    }

    if (event is LoadMarketToday) {
      yield MarketLoading();
      try {
        final response = await api.getMarketToday();
        prefs.setString("marketToday", marketTodayModelToMap(response));
        yield MarketTodayLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield MarketFailure(error: error.toString());
      }
    }

    if (event is BuyMarketToday) {
      yield MarketLoading();
      try {
        final response = await api.buyMarketToday(event.type);
        prefs.setString("marketToday", marketTodayModelToMap(response));
        yield MarketTodayLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield MarketFailure(error: error.toString());
      }
    }

    if (event is LoadMarket) {
      yield MarketLoading();
      try {
        final response = await api.getData(event.type);
        yield MarketTradingLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield MarketFailure(error: error.toString());
      }
    }

  }
}