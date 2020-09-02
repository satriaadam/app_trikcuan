import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trikcuan_app/core/api/dividen_api.dart';
import 'package:trikcuan_app/core/bloc/dividen/dividen_event.dart';
import 'package:trikcuan_app/core/bloc/dividen/dividen_state.dart';
import 'package:trikcuan_app/core/model/dividen_price_model.dart';
import 'package:trikcuan_app/core/model/dividen_today.dart';

class DividenBloc extends Bloc<DividenEvent, DividenState> {
  final api = DividenApi();

  DividenBloc() : super(DividenUninitialized());

  @override
  Stream<DividenState> mapEventToState(
      DividenEvent event,
      ) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (event is LoadDividenPrice) {
      yield DividenLoading();
      try {
        String json = prefs.getString("dividenPrice");
        if(json != null) {
          var account = dividenPriceModelFromMap(json);
          yield DividenPriceLoaded(data: account);
        }
        final response = await api.getPrices();
        if(response != null) {
          prefs.setString("dividenPrice", dividenPriceModelToMap(response));
          yield DividenPriceLoaded(data: response);
        }
      } catch (error) {
        print("ERROR: $error");
        yield DividenFailure(error: error.toString());
      }
    }

  //  if (event is LoadDividenToday) {
  //    yield DividenLoading();
  //    try {
  //      final response = await api.getDividenToday();
  //      prefs.setString("dividenToday", dividenTodayModelToMap(response));
  //      yield DividenTodayLoaded(data: response);
  //    } catch (error) {
  //      print("ERROR: $error");
  //      yield DividenFailure(error: error.toString());
  //    }
  //  }

    if (event is BuyDividenToday) {
      yield DividenLoading();
      try {
        final response = await api.buyDividenToday(event.type);
        prefs.setString("dividenToday", dividenTodayModelToMap(response));
        yield DividenTodayLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield DividenFailure(error: error.toString());
      }
    }

    if (event is LoadDividen) {
      yield DividenLoading();
      try {
        final response = await api.getData(event.type);
        yield DividenTradingLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield DividenFailure(error: error.toString());
      }
    }

  }
}