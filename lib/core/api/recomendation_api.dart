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
        url: "$host/recomendation/$type",
        useAuth: true
      );
      return recomendationModelFromMap(jsonEncode(jsonDecode(response)));
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
  
  Future<List<RecomendationTodayModel>> buyRecomendation({
    String recomendation, String type, String dataId, int price
  }) async {
    try {
      final response = await postRequest(
        url: "$host/recomendation/buy",
        useAuth: true,
        body: {
          "recomendation": recomendation,
          "type": type,
          "data_id": dataId,
          "price": price
        }
      );
      if(type == "recomendation")
        return recomendationTodayModelFromMap(response);
      else 
        return <RecomendationTodayModel>[];
    } catch (error) {
      throw Exception(error);
    }
  }
  
  Future<String> checkRecomendationData({String dataId, String recomendation, String date}) async {
    try {
      final response = await postRequest(
        url: "$host/recomendationdata/check",
        useAuth: true,
        body: {
          "data_id": dataId,
          "recomendation": recomendation,
          "date": date
        }
      );
      return response;
    } catch (error) {
      throw Exception(error);
    }
  }

}