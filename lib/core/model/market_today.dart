import 'dart:convert';

List<MarketTodayModel> marketTodayModelFromMap(String str) => List<MarketTodayModel>.from(json.decode(str).map((x) => MarketTodayModel.fromMap(x)));

String marketTodayModelToMap(List<MarketTodayModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class MarketTodayModel {
  MarketTodayModel({
    this.id,
    this.userId,
    this.marketType,
    this.price,
    this.date,
  });

  int id;
  String userId;
  String marketType;
  String price;
  DateTime date;

  factory MarketTodayModel.fromMap(Map<String, dynamic> json) => MarketTodayModel(
    id: json["id"],
    userId: json["user_id"],
    marketType: json["market_type"],
    price: json["price"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "market_type": marketType,
    "price": price,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  };
}
