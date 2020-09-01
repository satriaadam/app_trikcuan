import 'dart:convert';

List<RecomendationPriceModel> recomendationPriceModelFromMap(String str) => List<RecomendationPriceModel>.from(json.decode(str).map((x) => RecomendationPriceModel.fromMap(x)));

String recomendationPriceModelToMap(List<RecomendationPriceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class RecomendationPriceModel {
    RecomendationPriceModel({
        this.id,
        this.recomendation,
        this.price,
    });

    int id;
    String recomendation;
    String price;

    factory RecomendationPriceModel.fromMap(Map<String, dynamic> json) => RecomendationPriceModel(
        id: json["id"],
        recomendation: json["recomendation"],
        price: json["price"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "recomendation": recomendation,
        "price": price,
    };
}
