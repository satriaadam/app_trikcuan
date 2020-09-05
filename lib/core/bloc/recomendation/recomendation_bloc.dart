import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trikcuan_app/core/api/recomendation_api.dart';
import 'package:trikcuan_app/core/bloc/recomendation/recomendation_event.dart';
import 'package:trikcuan_app/core/bloc/recomendation/recomendation_state.dart';
import 'package:trikcuan_app/core/model/recomendation_model.dart';
import 'package:trikcuan_app/core/model/recomendation_price_model.dart';
import 'package:trikcuan_app/core/model/recomendation_today.dart';

class RecomendationBloc extends Bloc<RecomendationEvent, RecomendationState> {
  final api = RecomendationApi();

  RecomendationBloc() : super(RecomendationUninitialized());

  @override
  Stream<RecomendationState> mapEventToState(
    RecomendationEvent event,
  ) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (event is LoadRecomendationPrice) {
      yield RecomendationLoading();
      try {
        String json = prefs.getString("recomendationPrice");
        if(json != null) {
          var account = recomendationPriceModelFromMap(json);
          yield RecomendationPriceLoaded(data: account);
        }
        final response = await api.getPrices();
        if(response != null) {
          prefs.setString("recomendationPrice", recomendationPriceModelToMap(response));
          yield RecomendationPriceLoaded(data: response);
        }
      } catch (error) {
        print("ERROR: $error");
        yield RecomendationFailure(error: error.toString());
      }
    }
    
    if (event is LoadRecomendationToday) {
      yield RecomendationLoading();
      try {
        final response = await api.getRecomendationToday();
        prefs.setString("recomendationToday", recomendationTodayModelToMap(response));
        yield RecomendationTodayLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield RecomendationFailure(error: error.toString());
      }
    }
    
    if (event is BuyRecomendation) {
      yield RecomendationLoading();
      try {
        final response = await api.buyRecomendation(
          recomendation: event.recomendation,
          type: event.type,
          dataId: event.dataId,
          price: event.price
        );
        prefs.setString("recomendationToday", recomendationTodayModelToMap(response));
        yield RecomendationTodayLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield RecomendationFailure(error: error.toString());
      }
    }

    if (event is LoadRecomendation) {
      yield RecomendationLoading();
      try {
        var pref = prefs.getString("recomendation_${event.type}");
        if(pref != null) yield RecomendationTradingLoaded(data: recomendationModelFromMap(pref));
        final response = await api.getData(event.type);
        prefs.setString("recomendation_${event.type}", recomendationModelToMap(response));
        yield RecomendationTradingLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield RecomendationFailure(error: error.toString());
      }
    }
    
    if (event is CheckRecomendationData) {
      yield RecomendationLoading();
      try {
        await api.checkRecomendationData(
          dataId: event.dataId,
          recomendation: event.recomendation,
          date: event.date
        );
        yield RecomendationDataAvailable();
      } catch (error) {
        print("ERROR: $error");
        yield RecomendationFailure(error: error.toString());
      }
    }

  }
}