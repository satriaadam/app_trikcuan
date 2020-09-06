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
    String price;
    String priceChange;
    String percentageChange;
    String marketCategory;

    factory MarketModel.fromMap(Map<String, dynamic> json) => MarketModel(
        id: json["id"],
        code: json["code"],
        description: json["description"],
        price: json["price"],
        priceChange: json["price_change"],
        percentageChange: json["percentage_change"],
        marketCategory: json["market_category"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "code": code,
        "description": description,
        "price": price,
        "price_change": priceChange,
        "percentage_change": percentageChange,
        "market_category": marketCategory,
    };
}
