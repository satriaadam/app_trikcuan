import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trikcuan_app/core/api/recomendation_api.dart';
import 'package:trikcuan_app/core/bloc/recomendation/recomendation_event.dart';
import 'package:trikcuan_app/core/bloc/recomendation/recomendation_state.dart';
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
    
    if (event is BuyRecomendationToday) {
      yield RecomendationLoading();
      try {
        final response = await api.buyRecomendationToday(event.type);
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
        final response = await api.getData(event.type);
        yield RecomendationTradingLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield RecomendationFailure(error: error.toString());
      }
    }

  }
}