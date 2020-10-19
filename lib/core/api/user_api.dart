import 'package:trikcuan_app/core/api/main_api.dart';
import 'package:trikcuan_app/core/model/account_model.dart';

class UserApi extends MainApi {
  
  Future<List<Account>> getData({
    int page, 
    int limit, 
    String search
  }) async {
    try {
      final response = await getRequest(
        url: "$host/admin/users?page=$page&limit=$limit&search=${search ?? ''}",
        useAuth: true
      );
      return accountsFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }

}