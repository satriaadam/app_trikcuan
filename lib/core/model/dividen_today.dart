import 'dart:convert';

List<DividenTodayModel> dividenTodayModelFromMap(String str) => List<DividenTodayModel>.from(json.decode(str).map((x) => DividenTodayModel.fromMap(x)));

String dividenTodayModelToMap(List<DividenTodayModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class DividenTodayModel {
  DividenTodayModel({
    this.id,
    this.userId,
    this.dividenType,
    this.price,
    this.date,
  });

  int id;
  String userId;
  String dividenType;
  String price;
  DateTime date;

  factory DividenTodayModel.fromMap(Map<String, dynamic> json) => DividenTodayModel(
    id: json["id"],
    userId: json["user_id"],
    dividenType: json["dividen_type"],
    price: json["price"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "dividen_type": dividenType,
    "price": price,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  };
}
