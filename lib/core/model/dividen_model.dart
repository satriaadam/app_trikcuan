import 'dart:convert';

List<DividenModel> dividenModelFromMap(String str) => List<DividenModel>.from(json.decode(str).map((x) => DividenModel.fromMap(x)));

String dividenModelToMap(List<DividenModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class DividenModel {
    DividenModel({
        this.kodeSaham,
        this.potensi,
        this.cumdate,
        this.exdate,
        this.keterangan,
        this.beli,
        this.jual,
        this.price,
    });

    String kodeSaham;
    String potensi;
    DateTime cumdate;
    DateTime exdate;
    String keterangan;
    String beli;
    String jual;
    int price;

    factory DividenModel.fromMap(Map<String, dynamic> json) => DividenModel(
        kodeSaham: json["kode_saham"],
        potensi: json["potensi"],
        cumdate: DateTime.parse(json["cumdate"]),
        exdate: DateTime.parse(json["exdate"]),
        keterangan: json["keterangan"],
        beli: json["beli"],
        jual: json["jual"],
        price: json["price"],
    );

    Map<String, dynamic> toMap() => {
        "kode_saham": kodeSaham,
        "potensi": potensi,
        "cumdate": cumdate.toIso8601String(),
        "exdate": exdate.toIso8601String(),
        "keterangan": keterangan,
        "beli": beli,
        "jual": jual,
        "price": price,
    };
}