import 'dart:convert';

List<SahamLQ45TodayModel> sahamlq45TodayModelFromMap(String str) => List<SahamLQ45TodayModel>.from(json.decode(str).map((x) => SahamLQ45TodayModel.fromMap(x)));

String sahamlq45TodayModelToMap(List<SahamLQ45TodayModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class SahamLQ45TodayModel {
  SahamLQ45TodayModel({
    this.id,
    this.userId,
    this.sahamlq45Type,
    this.price,
    this.date,
  });

  int id;
  String userId;
  String sahamlq45Type;
  String price;
  DateTime date;

  factory SahamLQ45TodayModel.fromMap(Map<String, dynamic> json) => SahamLQ45TodayModel(
    id: json["id"],
    userId: json["user_id"],
    sahamlq45Type: json["sahamlq45_type"],
    price: json["price"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "sahamlq45_type": sahamlq45Type,
    "price": price,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  };
}
