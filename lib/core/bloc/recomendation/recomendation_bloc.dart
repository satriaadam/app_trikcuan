import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:trikcuan_app/core/api/recomendation_api.dart';
import 'package:trikcuan_app/core/bloc/recomendation/recomendation_event.dart';
import 'package:trikcuan_app/core/bloc/recomendation/recomendation_state.dart';

class RecomendationBloc extends Bloc<RecomendationEvent, RecomendationState> {
  final api = RecomendationApi();

  RecomendationBloc() : super(RecomendationUninitialized());

  @override
  Stream<RecomendationState> mapEventToState(
    RecomendationEvent event,
  ) async* {

    if (event is LoadRecomendationTrading) {
      yield RecomendationLoading();
      try {
        final response = await api.trading();
        yield RecomendationTradingLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield RecomendationFailure(error: error.toString());
      }
    }

  }
}