import 'dart:convert';

TopupModel topupModelFromMap(String str) => TopupModel.fromMap(json.decode(str));

String topupModelToMap(TopupModel data) => json.encode(data.toMap());

List<TopupModel> topupsFromMap(String str) => List<TopupModel>.from(json.decode(str).map((x) => TopupModel.fromMap(x)));

String topupsToMap(List<TopupModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class TopupModel {
    TopupModel({
        this.id,
        this.balance,
        this.name,
        this.phoneNumber,
        this.status,
        this.transferTo,
        this.whatsapp,
        this.expiredDate,
        this.approvedDate,
        this.createdAt,
    });

    int id;
    int balance;
    String name;
    String phoneNumber;
    String status;
    String transferTo;
    String whatsapp;
    DateTime expiredDate;
    DateTime approvedDate;
    DateTime createdAt;

    factory TopupModel.fromMap(Map<String, dynamic> json) => TopupModel(
        id: json["id"],
        balance: json["balance"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        status: json["status"],
        expiredDate: json["expired_date"] != null ? DateTime.parse(json["expired_date"]) : null,
        approvedDate: json["approved_date"] != null ? DateTime.parse(json["approved_date"]) : null,
        transferTo: json["transfer_to"],
        whatsapp: json["whatsapp"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "balance": balance,
        "name": name,
        "phone_number": phoneNumber,
        "status": status,
        "expired_date": expiredDate.toIso8601String(),
        "approved_date": approvedDate,
        "transfer_to": transferTo,
        "whatsapp": whatsapp,
        "created_at": createdAt.toIso8601String(),
    };
}
