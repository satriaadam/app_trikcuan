import 'dart:convert';

import 'package:trikcuan_app/core/api/main_api.dart';
import 'package:trikcuan_app/core/model/dividen_model.dart';
import 'package:trikcuan_app/core/model/dividen_price_model.dart';
import 'package:trikcuan_app/core/model/dividen_today.dart';

class DividenApi extends MainApi {

  Future<List<DividenPriceModel>> getPrices() async {
    try {
      final response = await getRequest(
        url: "$host/general/dividen-price",
      );
      return dividenPriceModelFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<DividenModel>> getData() async {
    try {
      final response = await getRequest(
        url: "http://script.google.com/macros/s/AKfycbxS4eCKGo--UbuEyXorXpxUZU9nh9l7zoDt5Dpyx1cqZ1zVRK4/exec?id=12LdzZxoBz0OIN9jnCQ3RVum8Ce_J1Fw088X8cDAlHDo&sheet=dividen",
      );
      return dividenModelFromMap(jsonEncode(jsonDecode(response)['data']));
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<DividenTodayModel>> geDividennToday() async {
    try {
      final response = await getRequest(
          url: "$host/dividen/today",
          useAuth: true
      );
      return dividenTodayModelFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<DividenTodayModel>> buyDividenToday(String type) async {
    try {
      final response = await postRequest(
          url: "$host/dividen/buy",
          useAuth: true,
          body: {
            "dividen": type,
            "type": "dividen"
          }
      );
      return dividenTodayModelFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }

}