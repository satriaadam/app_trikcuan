import 'dart:convert';

import 'package:trikcuan_app/core/api/main_api.dart';
import 'package:trikcuan_app/core/model/market_model.dart';

class MarketApi extends MainApi {

  Future<List<MarketModel>> getData(String type) async {
    try {
      final response = await getRequest(
        url: "$host/market/$type",
        useAuth: true
      );
      return marketModelFromMap(jsonEncode(jsonDecode(response)));
    } catch (error) {
      throw Exception(error);
    }
  }

}