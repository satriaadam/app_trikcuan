import 'dart:convert';

import 'package:trikcuan_app/core/api/main_api.dart';
import 'package:trikcuan_app/core/model/recomendation_model.dart';

class RecomendationApi extends MainApi {
  
  Future<List<RecomendationModel>> trading() async {
    try {
      final response = await getRequest(
        url: "http://script.google.com/macros/s/AKfycbxS4eCKGo--UbuEyXorXpxUZU9nh9l7zoDt5Dpyx1cqZ1zVRK4/exec?id=12LdzZxoBz0OIN9jnCQ3RVum8Ce_J1Fw088X8cDAlHDo&sheet=trading",
      );
      return recomendationModelFromMap(jsonEncode(jsonDecode(response)['data']));
    } catch (error) {
      throw Exception(error);
    }
  }

}