import 'dart:convert';

List<MarketModel> marketModelFromMap(String str) => List<MarketModel>.from(json.decode(str).map((x) => MarketModel.fromMap(x)));

String marketModelToMap(List<MarketModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class MarketModel {
    MarketModel({
        this.id,
        this.category,
        this.code,
        this.description,
        this.price,
        this.priceChange,
        this.percentageChange,
    });

    String id;
    String category;
    String code;
    String description;
    String price;
    String priceChange;
    String percentageChange;

    factory MarketModel.fromMap(Map<String, dynamic> json) => MarketModel(
        id: json["id"].toString(),
        category: json["category"].toString(),
        code: json["code"].toString(),
        description: json["description"].toString(),
        price: json["price"].toString(),
        priceChange: json["price_change"].toString(),
        percentageChange: json["percentage_change"].toString(),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "category": categoryValues.reverse[category],
        "code": code,
        "description": description,
        "price": price,
        "price_change": priceChange,
        "percentage_change": percentageChange,
    };
}

enum Category { AMERICA, ASIA, EROPA }

final categoryValues = EnumValues({
    "America": Category.AMERICA,
    "Asia": Category.ASIA,
    "Eropa": Category.EROPA
});

enum PercentageChange { THE_031, PERCENTAGE_CHANGE_031 }

final percentageChangeValues = EnumValues({
    "-0.31%": PercentageChange.PERCENTAGE_CHANGE_031,
    "+0.31%": PercentageChange.THE_031
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
