import 'dart:convert';

import 'package:trikcuan_app/core/api/main_api.dart';
import 'package:trikcuan_app/core/model/market_model.dart';
import 'package:trikcuan_app/core/model/market_price_model.dart';
import 'package:trikcuan_app/core/model/market_today.dart';

class MarketApi extends MainApi {

  Future<List<MarketPriceModel>> getPrices() async {
    try {
      final response = await getRequest(
        url: "$host/general/market-price",
      );
      return marketPriceModelFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<MarketModel>> getData(String type) async {
    try {
      final response = await getRequest(
        url: "http://script.google.com/macros/s/AKfycbxS4eCKGo--UbuEyXorXpxUZU9nh9l7zoDt5Dpyx1cqZ1zVRK4/exec?id=12LdzZxoBz0OIN9jnCQ3RVum8Ce_J1Fw088X8cDAlHDo&sheet=$type",
      );
      return marketModelFromMap(jsonEncode(jsonDecode(response)['data']));
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<MarketTodayModel>> getMarketToday() async {
    try {
      final response = await getRequest(
          url: "$host/market/today",
          useAuth: true
      );
      return marketTodayModelFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<MarketTodayModel>> buyMarketToday(String type) async {
    try {
      final response = await postRequest(
          url: "$host/market/buy",
          useAuth: true,
          body: {
            "market": type,
            "type": "market"
          }
      );
      return marketTodayModelFromMap(response);
    } catch (error) {
      throw Exception(error);
    }
  }

}