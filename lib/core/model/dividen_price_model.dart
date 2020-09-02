import 'dart:convert';

List<DividenPriceModel> dividenPriceModelFromMap(String str) => List<DividenPriceModel>.from(json.decode(str).map((x) => DividenPriceModel.fromMap(x)));

String dividenPriceModelToMap(List<DividenPriceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class DividenPriceModel {
  DividenPriceModel({
    this.id,
    this.dividen,
    this.price,
  });

  int id;
  String dividen;
  String price;

  factory DividenPriceModel.fromMap(Map<String, dynamic> json) => DividenPriceModel(
    id: json["id"],
    dividen: json["dividen"],
    price: json["price"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "dividen": dividen,
    "price": price,
  };
}
