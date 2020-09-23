import 'dart:convert';

List<MarketModel> marketModelFromMap(String str) => List<MarketModel>.from(json.decode(str).map((x) => MarketModel.fromMap(x)));

String marketModelToMap(List<MarketModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class MarketModel {
    MarketModel({
        this.id,
        this.code,
        this.description,
        this.price,
        this.priceChange,
        this.percentageChange,
        this.marketCategory,
    });

    int id;
    String code;
    String description;
    double price;
    double priceChange;
    double percentageChange;
    String marketCategory;

    factory MarketModel.fromMap(Map<String, dynamic> json) => MarketModel(
        id: json["id"],
        code: json["code"],
        description: json["description"],
        price: double.parse(json["price"].toString()),
        priceChange: double.parse(json["price_change"].toString()),
        percentageChange: double.parse(json["percentage_change"].toString()),
        marketCategory: json["market_category"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "code": code,
        "description": description,
        "price": price.toString(),
        "price_change": priceChange.toString(),
        "percentage_change": percentageChange.toString(),
        "market_category": marketCategory,
    };
}
