import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trikcuan_app/core/api/sahamlq45_api.dart';
import 'package:trikcuan_app/core/bloc/sahamlq45/sahamlq45_event.dart';
import 'package:trikcuan_app/core/bloc/sahamlq45/sahamlq45_state.dart';
import 'package:trikcuan_app/core/model/sahamlq45_model.dart';
import 'package:trikcuan_app/core/model/sahamlq45_price_model.dart';
import 'package:trikcuan_app/core/model/sahamlq45_today.dart';

class SahamLQ45Bloc extends Bloc<SahamLQ45Event, SahamLQ45State> {
  final api = SahamLQ45Api();

SahamLQ45Bloc() : super(SahamLQ45Uninitialized());

  @override
  Stream<SahamLQ45State> mapEventToState(
      SahamLQ45Event event,
      ) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (event is LoadSahamLQ45Price) {
      yield SahamLQ45Loading();
      try {
        String json = prefs.getString("sahamlq45Price");
        if(json != null) {
          var account = sahamlq45PriceModelFromMap(json);
          yield SahamLQ45PriceLoaded(data: account);
        }
        final response = await api.getPrices();
        if(response != null) {
          prefs.setString("sahamlq45Price", sahamlq45PriceModelToMap(response));
          yield SahamLQ45PriceLoaded(data: response);
        }
      } catch (error) {
        print("ERROR: $error");
        yield SahamLQ45Failure(error: error.toString());
      }
    }

    if (event is LoadSahamLQ45Today) {
      yield SahamLQ45Loading();
      try {
        final response = await api.getSahamLQ45Today();
        prefs.setString("sahamlq45Today", sahamlq45TodayModelToMap(response));
        yield SahamLQ45TodayLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield SahamLQ45Failure(error: error.toString());
      }
    }

    if (event is BuySahamLQ45) {
      yield SahamLQ45Loading();
      try {
        final response = await api.buySahamLQ45(
            sahamlq45: event.sahamlq45,
            type: event.type,
            dataId: event.dataId,
            price: event.price
        );
        prefs.setString("sahamlq45Today", sahamlq45TodayModelToMap(response));
        yield SahamLQ45TodayLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield SahamLQ45Failure(error: error.toString());
      }
    }

    if (event is LoadSahamLQ45) {
      yield SahamLQ45Loading();
      try {
        var pref = prefs.getString("sahamlq45_${event.type}");
        if(pref != null) yield SahamLQ45TradingLoaded(data: sahamlq45ModelFromMap(pref));
        final response = await api.getData(event.type);
        prefs.setString("sahamlq45_${event.type}", sahamlq45ModelToMap(response));
        yield SahamLQ45TradingLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield SahamLQ45Failure(error: error.toString());
      }
    }

    if (event is CheckSahamLQ45Data) {
      yield SahamLQ45Loading();
      try {
        await api.checkSahamLQ45Data(
            dataId: event.dataId,
            sahamlq45: event.sahamlq45,
            date: event.date
        );
        yield SahamLQ45DataAvailable();
      } catch (error) {
        print("ERROR: $error");
        yield SahamLQ45Failure(error: error.toString());
      }
    }

  }
}