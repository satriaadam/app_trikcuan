import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:trikcuan_app/core/api/dividen_api.dart';
import 'package:trikcuan_app/core/bloc/dividen/dividen_event.dart';
import 'package:trikcuan_app/core/bloc/dividen/dividen_state.dart';

class DividenBloc extends Bloc<DividenEvent, DividenState> {
  final api = DividenApi();

  DividenBloc() : super(DividenUninitialized());

  @override
  Stream<DividenState> mapEventToState(
    DividenEvent event,
  ) async* {

    if (event is LoadDividen) {
      yield DividenLoading();
      try {
        final response = await api.getData();
        yield DividensLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield DividenFailure(error: error.toString());
      }
    }

  }
}