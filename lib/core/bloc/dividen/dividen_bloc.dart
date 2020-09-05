import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trikcuan_app/core/api/dividen_api.dart';
import 'package:trikcuan_app/core/bloc/dividen/dividen_event.dart';
import 'package:trikcuan_app/core/bloc/dividen/dividen_state.dart';
import 'package:trikcuan_app/core/model/dividen_model.dart';

class DividenBloc extends Bloc<DividenEvent, DividenState> {
  final api = DividenApi();

  DividenBloc() : super(DividenUninitialized());

  @override
  Stream<DividenState> mapEventToState(DividenEvent event) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (event is LoadDividen) {
      yield DividenLoading();
      try {
        var pref = prefs.getString("dividen");
        if(pref != null) yield DividensLoaded(data: dividenModelFromMap(pref));
        final response = await api.getData();
        prefs.setString("dividen", dividenModelToMap(response));
        yield DividensLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield DividenFailure(error: error.toString());
      }
    }
    
    if (event is CheckDividen) {
      yield DividenLoading();
      try {
        await api.checkDividen(dataId: event.dataId);
        yield DividenAvailable();
      } catch (error) {
        print("ERROR: $error");
        yield DividenFailure(error: error.toString());
      }
    }
    
    if (event is BuyDividen) {
      yield DividenLoading();
      try {
        await api.buyDividen(dataId: event.dataId, price: event.price);
        yield BuyDividenSuccess();
      } catch (error) {
        print("ERROR: $error");
        yield DividenFailure(error: error.toString());
      }
    }

  }
}