import 'dart:convert';

TopupModel topupModelFromMap(String str) => TopupModel.fromMap(json.decode(str));

String topupModelToMap(TopupModel data) => json.encode(data.toMap());

class TopupModel {
    TopupModel({
        this.id,
        this.balance,
        this.status,
        this.transferTo,
        this.whatsapp,
        this.expiredDate,
        this.approvedDate,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    int balance;
    String status;
    String transferTo;
    String whatsapp;
    DateTime expiredDate;
    DateTime approvedDate;
    DateTime createdAt;
    DateTime updatedAt;

    factory TopupModel.fromMap(Map<String, dynamic> json) => TopupModel(
        id: json["id"],
        balance: json["balance"],
        status: json["status"],
        expiredDate: json["expired_date"] != null ? DateTime.parse(json["expired_date"]) : null,
        approvedDate: json["approved_date"] != null ? DateTime.parse(json["approved_date"]) : null,
        transferTo: json["transfer_to"],
        whatsapp: json["whatsapp"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "balance": balance,
        "status": status,
        "expired_date": expiredDate.toIso8601String(),
        "approved_date": approvedDate,
        "transfer_to": transferTo,
        "whatsapp": whatsapp,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
