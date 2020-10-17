import 'package:trikcuan_app/core/api/main_api.dart';
import 'package:trikcuan_app/core/model/recomendation_model.dart';

class AdminRecomendationApi extends MainApi {
  
  Future<List<RecomendationModel>> getData({
    String type,
    String date
  }) async {
    try {
      final response = await getRequest(
        url: "$host/admin/recomendation",
        useAuth: true
      );
      return recomendationModelFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }
  
  Future<RecomendationModel> addData({
    RecomendationPost data
  }) async {
    try {
      final response = await postRequest(
        url: "$host/admin/recomendation/add",
        body: data.toMap(),
        useAuth: true
      );
      return recomendationDetailFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<RecomendationModel> editData({
    RecomendationPost data,
    String id
  }) async {
    try {
      final response = await postRequest(
        url: "$host/admin/recomendation/edit/$id",
        body: data.toMap(),
        useAuth: true
      );
      return recomendationDetailFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }

}