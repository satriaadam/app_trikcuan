import 'dart:convert';

List<MarketPriceModel> marketPriceModelFromMap(String str) => List<MarketPriceModel>.from(json.decode(str).map((x) => MarketPriceModel.fromMap(x)));

String marketPriceModelToMap(List<MarketPriceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class MarketPriceModel {
  MarketPriceModel({
    this.id,
    this.market,
    this.price,
  });

  int id;
  String market;
  String price;

  factory MarketPriceModel.fromMap(Map<String, dynamic> json) => MarketPriceModel(
    id: json["id"],
    market: json["market"],
    price: json["price"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "market": market,
    "price": price,
  };
}
