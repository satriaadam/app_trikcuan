import 'dart:convert';

import 'package:trikcuan_app/core/api/main_api.dart';
import 'package:trikcuan_app/core/model/dividen_model.dart';
import 'package:trikcuan_app/core/model/dividen_price_model.dart';

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
        url: "$host/dividens",
        useAuth: true
      );
      return dividenModelFromMap(jsonEncode(jsonDecode(response)));
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<String> buyDividen({
    String dataId, int price
  }) async {
    try {
      final response = await postRequest(
        url: "$host/dividen/buy",
        useAuth: true,
        body: {
          "data_id": dataId,
          "price": price
        }
      );
      return response;
    } catch (error) {
      throw Exception(error);
    }
  }
  
  Future<String> checkDividen({String dataId}) async {
    try {
      final response = await postRequest(
        url: "$host/dividen/check",
        useAuth: true,
        body: {
          "data_id": dataId
        }
      );
      return response;
    } catch (error) {
      throw Exception(error);
    }
  }

}