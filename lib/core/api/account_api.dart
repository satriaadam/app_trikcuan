import 'package:trikcuan_app/core/api/main_api.dart';
import 'package:trikcuan_app/core/model/account_model.dart';
import 'package:trikcuan_app/core/model/topup_model.dart';

class AccountApi extends MainApi {
  
  Future<Account> profile() async {
    try {
      final response = await getRequest(
        url: "$host/profile",
        useAuth: true
      );
      print(response);
      return accountFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }
  
  Future<Account> buyConsultation() async {
    try {
      final response = await getRequest(
        url: "$host/consultation/buy",
        useAuth: true
      );
      print(response);
      return accountFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<TopupModel> topup(int saldo) async {
    try {
      final response = await postRequest(
        url: "$host/profile/topup",
        useAuth: true,
        body: {
          "balance": saldo
        }
      );
      print(response);
      return topupModelFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }

}