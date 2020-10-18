import 'package:trikcuan_app/core/api/main_api.dart';
import 'package:trikcuan_app/core/model/topup_model.dart';

class BalanceTopUpApi extends MainApi {
  
  Future<List<TopupModel>> getData({int page, int limit}) async {
    try {
      final response = await getRequest(
        url: "$host/admin/topup?page=$page&limit=$limit",
        useAuth: true
      );
      return topupsFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }
  
  Future<TopupModel> verify({int id}) async {
    try {
      final response = await getRequest(
        url: "$host/admin/topup/verify/$id",
        useAuth: true
      );
      return topupModelFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }

}