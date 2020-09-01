import 'package:trikcuan_app/core/api/main_api.dart';
import 'package:trikcuan_app/core/model/account_model.dart';

class AuthApi extends MainApi {
  
  Future<Account> login({String username, String password}) async {
    try {
      final response = await postRequest(
        url: "$host/login",
        body: {
          "username": username,
          "password": password
        }
      );
      print(response);
      return accountFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }
  
  Future<Account> register({RegisterAccount data}) async {
    try {
      final response = await postRequest(
        url: "$host/register",
        body: data.toMap()
      );
      return accountFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }

}