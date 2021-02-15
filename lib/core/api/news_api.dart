import 'dart:convert';

import 'package:trikcuan_app/core/api/main_api.dart';
import 'package:trikcuan_app/core/model/news_model.dart';

class NewsApi extends MainApi {

  Future<List<NewsModel>> getData() async {
    try {
      final response = await getRequest(
        url: "$host/news",
        useAuth: true
      );
      return newsModelFromMap(jsonEncode(jsonDecode(response)));
    } catch (error) {
      throw Exception(error);
    }
  }

}