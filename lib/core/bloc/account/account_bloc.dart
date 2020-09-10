import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trikcuan_app/core/api/account_api.dart';
import 'package:trikcuan_app/core/bloc/account/account_event.dart';
import 'package:trikcuan_app/core/bloc/account/account_state.dart';
import 'package:trikcuan_app/core/model/account_model.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final api = AccountApi();

  AccountBloc() : super(AccountUninitialized());

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (event is GetAccount) {
      yield AccountLoading();
      try {
        String json = prefs.getString("account");
        print(json);
        var account = accountFromMap(json);
        yield AccountSuccess(data: account);
        final response = await api.profile();
        if(response != null) {
          prefs.setString("account", jsonEncode(response.toMap()));
          yield AccountSuccess(data: response);
        }
      } catch (error) {
        print("ERROR: $error");
        yield AccountFailure(error: error.toString());
      }
    }
    
    if (event is RequestTopupSaldo) {
      yield AccountLoading();
      try {
        final response = await api.topup(event.saldo);
        yield RequestTopupSaldoSuccess(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield AccountFailure(error: error.toString());
      }
    }
    
    if (event is BuyConsultation) {
      yield AccountLoading();
      try {
        final response = await api.buyConsultation();
        if(response != null) {
          prefs.setString("account", jsonEncode(response.toMap()));
          yield BuyConsultationSuccess(data: response);
        }
      } catch (error) {
        print("ERROR: $error");
        yield AccountFailure(error: error.toString());
      }
    }

    // if (event is UpdateEmail) {
    //   yield AccountLoading();
    //   try {
    //     final response = await api.updateEmail(email: event.email);
    //     prefs.setString("account", jsonEncode(response));
    //     yield UpdateEmailSuccess(data: response);
    //   } catch (error) {
    //     print("ERROR: $error");
    //     yield AccountFailure(error: error.toString());
    //   }
    // }
    
    // if (event is EditProfile) {
    //   yield AccountLoading();
    //   try {
    //     final response = await api.editProfile(
    //       data: event.data
    //     );
    //     prefs.setString("account", jsonEncode(response));
    //     yield EditProfileSuccess(data: response);
    //   } catch (error) {
    //     print("ERROR: $error");
    //     yield AccountFailure(error: error.toString());
    //   }
    // }

  }
}