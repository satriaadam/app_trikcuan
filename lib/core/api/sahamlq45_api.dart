import 'dart:convert';

import 'package:trikcuan_app/core/api/main_api.dart';
import 'package:trikcuan_app/core/model/sahamlq45_model.dart';
import 'package:trikcuan_app/core/model/sahamlq45_price_model.dart';
import 'package:trikcuan_app/core/model/sahamlq45_today.dart';

class SahamLQ45Api extends MainApi {

  Future<List<SahamLQ45PriceModel>> getPrices() async {
    try {
      final response = await getRequest(
        url: "$host/general/sahamlq45-price",
      );
      return sahamlq45PriceModelFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<SahamLQ45Model>> getData(String type) async {
    try {
      final response = await getRequest(
          url: "$host/sahamlq45/$type",
          useAuth: true
      );
      return sahamlq45ModelFromMap(jsonEncode(jsonDecode(response)));
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<SahamLQ45TodayModel>> getSahamLQ45Today() async {
    try {
      final response = await getRequest(
          url: "$host/sahamlq45/today",
          useAuth: true
      );
      return sahamlq45TodayModelFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<SahamLQ45TodayModel>> buySahamLQ45({
    String sahamlq45, String type, String dataId, int price
  }) async {
    try {
      final response = await postRequest(
          url: "$host/sahamlq45/buy",
          useAuth: true,
          body: {
            "sahamlq45": sahamlq45,
            "type": type,
            "data_id": dataId,
            "price": price
          }
      );
      if(type == "sahamlq45")
        return sahamlq45TodayModelFromMap(response);
      else
        return <SahamLQ45TodayModel>[];
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<String> checkSahamLQ45Data({String dataId, String sahamlq45, String date}) async {
    try {
      final response = await postRequest(
          url: "$host/sahamlq45/check",
          useAuth: true,
          body: {
            "data_id": dataId,
            "sahamlq45": sahamlq45,
            "date": date
          }
      );
      return response;
    } catch (error) {
      throw Exception(error);
    }
  }

}