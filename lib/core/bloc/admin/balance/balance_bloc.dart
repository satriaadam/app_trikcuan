import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:trikcuan_app/core/api/balance_topup_api.dart';
import 'package:trikcuan_app/core/bloc/admin/balance/balance_event.dart';
import 'package:trikcuan_app/core/bloc/admin/balance/balance_state.dart';

class BalanceTopupBloc extends Bloc<BalanceTopupEvent, BalanceTopupState> {
  final api = BalanceTopUpApi();
  int page = 1;
  int limit = 30;

  BalanceTopupBloc() : super(BalanceTopUpUninitialized());

  @override
  Stream<BalanceTopupState> mapEventToState(BalanceTopupEvent event) async* {
    final currentState = state;

    if (event is GetData) {
      page = event.page ?? page;
      limit = event.limit ?? limit;
      if(event.isRefresh || currentState is BalanceTopUpUninitialized) {
          page = event.page ?? 1;
      } else if(currentState is BalanceTopUpLoaded){
          int length = currentState.data.length;
          if(length%limit > 0)  
            yield currentState.copyWith(hasReachedMax: true);
          page = (currentState.data.length/limit).ceil() + 1;
      }

      try {
        yield BalanceTopUpLoading();
        final response = await api.getData(
          page: page,
          limit: limit
        );
        if(event.isRefresh || currentState is BalanceTopUpUninitialized) {
          yield BalanceTopUpLoaded(data: response, hasReachedMax: response.length < limit);
        } else if(currentState is BalanceTopUpLoaded){
          if(response.length > 0)
            yield BalanceTopUpLoaded(data: currentState.data + response, hasReachedMax: response.length < limit);
          else
            yield currentState.copyWith(hasReachedMax: true);
        }
      } catch (error) {
        print("ERROR: $error");
        yield BalanceTopUpFailure(error: error.toString());
      }
    }

    if(event is VerifyTopup) {
      try {
        yield BalanceTopUpLoading();
        final response = await api.verify(id: event.id);
        yield TopupVerified(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield BalanceTopUpFailure(error: error.toString());
      }
    }

  }
}