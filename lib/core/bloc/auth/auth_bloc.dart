import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:trikcuan_app/core/api/auth_api.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_event.dart';
import 'package:trikcuan_app/core/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final api = AuthApi();

  AuthBloc() : super(AuthUninitialized());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (event is AppStarted) {
      final isAuthenticated = prefs.getBool("isAuthenticated") ?? false;
      await Future.delayed(Duration(seconds: 3));
      if (isAuthenticated) {
        yield AuthAuthenticated();
      } else {
        yield AuthUnauthenticated();
      }
    }
    
    if (event is Register) {
      yield AuthLoading();
      try {
        final response = await api.register(data: event.data);
        prefs.setString("apiToken", response.accessToken);
        prefs.setString("account", jsonEncode(response));
        prefs.setBool("isAuthenticated", true);
        yield RegisterSuccess(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield AuthFailure(error: error.toString());
      }
    }
    
    if (event is Login) {
      yield AuthLoading();
      try {
        final response = await api.login(username: event.username, password: event.password);
        prefs.setString("apiToken", response.accessToken);
        prefs.setString("account", jsonEncode(response));
        prefs.setBool("isAuthenticated", true);
        yield AuthLoginSuccess(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield AuthFailure(error: error.toString());
      }
    }
    
    if (event is Logout) {
      yield AuthLoading();
      prefs.clear();
      yield AuthUnauthenticated();
    }

  }
}