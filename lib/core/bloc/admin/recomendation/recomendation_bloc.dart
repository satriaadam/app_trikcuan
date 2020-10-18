import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:trikcuan_app/core/api/admin_recomendation_api.dart';
import 'package:trikcuan_app/core/bloc/admin/recomendation/recomendation_event.dart';
import 'package:trikcuan_app/core/bloc/admin/recomendation/recomendation_state.dart';

class AdminRecomendationBloc extends Bloc<AdminRecomendationEvent, AdminRecomendationState> {
  final api = AdminRecomendationApi();

  AdminRecomendationBloc() : super(RecomendationUninitialized());

  @override
  Stream<AdminRecomendationState> mapEventToState(
    AdminRecomendationEvent event,
  ) async* {

    if (event is LoadRecomendation) {
      yield RecomendationLoading();
      try {
        final response = await api.getData(type: "dividen", date: "2020-10-17");
        yield RecomendationLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield RecomendationFailure(error: error.toString());
      }
    }
    
    if (event is AddRecomendation) {
      yield RecomendationLoading();
      try {
        final response = await api.addData(data: event.data);
        yield RecomendationCreated(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield RecomendationFailure(error: error.toString());
      }
    }
    
    if (event is EditRecomendation) {
      yield RecomendationLoading();
      try {
        final response = await api.editData(data: event.data, id: event.id);
        yield RecomendationCreated(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield RecomendationFailure(error: error.toString());
      }
    }
    
    if (event is DeleteRecomendation) {
      yield RecomendationLoading();
      try {
        await api.deleteData(id: event.id);
        yield RecomendationDeleted(id: event.id);
      } catch (error) {
        print("ERROR: $error");
        yield RecomendationFailure(error: error.toString());
      }
    }

  }
}