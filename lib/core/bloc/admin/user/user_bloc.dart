import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:trikcuan_app/core/api/user_api.dart';
import 'package:trikcuan_app/core/bloc/admin/user/user_event.dart';
import 'package:trikcuan_app/core/bloc/admin/user/user_state.dart';

class AdminUserBloc extends Bloc<AdminUserEvent, AdminUserState> {
  final api = UserApi();
  int page = 1;
  int limit = 30;

  AdminUserBloc() : super(AdminUserUninitialized());

  @override
  Stream<AdminUserState> mapEventToState(AdminUserEvent event) async* {
    final currentState = state;

    if (event is AdminLoadUsers) {
      page = event.page ?? page;
      limit = event.limit ?? limit;
      if(event.isRefresh || currentState is AdminUserUninitialized) {
          page = event.page ?? 1;
      } else if(currentState is AdminUserLoaded){
          int length = currentState.data.length;
          if(length%limit > 0)  
            yield currentState.copyWith(hasReachedMax: true);
          page = (currentState.data.length/limit).ceil() + 1;
      }

      try {
        yield AdminUserLoading();
        final response = await api.getData(
          page: page,
          limit: limit,
          search: event.search
        );
        if(event.isRefresh || currentState is AdminUserUninitialized) {
          yield AdminUserLoaded(data: response, hasReachedMax: response.length < limit);
        } else if(currentState is AdminUserLoaded){
          if(response.length > 0)
            yield AdminUserLoaded(data: currentState.data + response, hasReachedMax: response.length < limit);
          else
            yield currentState.copyWith(hasReachedMax: true);
        }
      } catch (error) {
        print("ERROR: $error");
        yield AdminUserFailure(error: error.toString());
      }
    }

  }
}