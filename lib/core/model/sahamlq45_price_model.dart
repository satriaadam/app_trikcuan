import 'dart:convert';

List<SahamLQ45PriceModel> sahamlq45PriceModelFromMap(String str) => List<SahamLQ45PriceModel>.from(json.decode(str).map((x) => SahamLQ45PriceModel.fromMap(x)));

String sahamlq45PriceModelToMap(List<SahamLQ45PriceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class SahamLQ45PriceModel {
  SahamLQ45PriceModel({
    this.id,
    this.sahamlq45,
    this.price,
  });

  int id;
  String sahamlq45;
  String price;

  factory SahamLQ45PriceModel.fromMap(Map<String, dynamic> json) => SahamLQ45PriceModel(
    id: json["id"],
    sahamlq45: json["sahamlq45"],
    price: json["price"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "sahamlq45": sahamlq45,
    "price": price,
  };
}
