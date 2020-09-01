import 'dart:convert';

import 'package:trikcuan_app/core/api/main_api.dart';
import 'package:trikcuan_app/core/model/recomendation_model.dart';
import 'package:trikcuan_app/core/model/recomendation_price_model.dart';
import 'package:trikcuan_app/core/model/recomendation_today.dart';

class RecomendationApi extends MainApi {
  
  Future<List<RecomendationPriceModel>> getPrices() async {
    try {
      final response = await getRequest(
        url: "$host/general/recomendation-price",
      );
      return recomendationPriceModelFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }
  
  Future<List<RecomendationModel>> getData(String type) async {
    try {
      final response = await getRequest(
        url: "http://script.google.com/macros/s/AKfycbxS4eCKGo--UbuEyXorXpxUZU9nh9l7zoDt5Dpyx1cqZ1zVRK4/exec?id=12LdzZxoBz0OIN9jnCQ3RVum8Ce_J1Fw088X8cDAlHDo&sheet=$type",
      );
      return recomendationModelFromMap(jsonEncode(jsonDecode(response)['data']));
    } catch (error) {
      throw Exception(error);
    }
  }
  
  Future<List<RecomendationTodayModel>> getRecomendationToday() async {
    try {
      final response = await getRequest(
        url: "$host/recomendation/today",
        useAuth: true
      );
      return recomendationTodayModelFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }
  
  Future<List<RecomendationTodayModel>> buyRecomendationToday(String type) async {
    try {
      final response = await postRequest(
        url: "$host/recomendation/buy",
        useAuth: true,
        body: {
          "recomendation": type,
          "type": "recomendation"
        }
      );
      return recomendationTodayModelFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }

}