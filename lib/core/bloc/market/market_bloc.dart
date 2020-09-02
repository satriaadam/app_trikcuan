import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:trikcuan_app/core/api/market_api.dart';
import 'package:trikcuan_app/core/bloc/market/market_event.dart';
import 'package:trikcuan_app/core/bloc/market/market_state.dart';

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final api = MarketApi();

  MarketBloc() : super(MarketUninitialized());

  @override
  Stream<MarketState> mapEventToState(
      MarketEvent event,
      ) async* {

    if (event is LoadMarket) {
      yield MarketLoading();
      try {
        final response = await api.getData(event.type);
        yield MarketLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield MarketFailure(error: error.toString());
      }
    }

  }
}