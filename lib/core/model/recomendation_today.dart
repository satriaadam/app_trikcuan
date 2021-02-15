import 'dart:convert';

List<RecomendationTodayModel> recomendationTodayModelFromMap(String str) => List<RecomendationTodayModel>.from(json.decode(str).map((x) => RecomendationTodayModel.fromMap(x)));

String recomendationTodayModelToMap(List<RecomendationTodayModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class RecomendationTodayModel {
    RecomendationTodayModel({
        this.id,
        this.userId,
        this.recomendationType,
        this.price,
        this.date,
    });

    int id;
    String userId;
    String recomendationType;
    String price;
    DateTime date;

    factory RecomendationTodayModel.fromMap(Map<String, dynamic> json) => RecomendationTodayModel(
        id: json["id"],
        userId: json["user_id"],
        recomendationType: json["recomendation_type"],
        price: json["price"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "recomendation_type": recomendationType,
        "price": price,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    };
}
