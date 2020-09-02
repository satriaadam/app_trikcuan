import 'dart:convert';

List<MarketModel> marketModelFromMap(String str) => List<MarketModel>.from(json.decode(str).map((x) => MarketModel.fromMap(x)));

String marketModelToMap(List<MarketModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class MarketModel {
  MarketModel({
    this.kodeSaham,
    this.potensiKenaikan,
    this.fundamental,
    this.teknikal,
    this.sentimen,
    this.beli,
    this.jual,
  });

  String kodeSaham;
  String potensiKenaikan;
  String fundamental;
  String teknikal;
  String sentimen;
  String beli;
  String jual;

  factory MarketModel.fromMap(Map<String, dynamic> json) => MarketModel(
    kodeSaham: json["kode_saham"],
    potensiKenaikan: json["potensi_kenaikan"],
    fundamental: json["fundamental"],
    teknikal: json["teknikal"],
    sentimen: json["sentimen"],
    beli: json["beli"],
    jual: json["jual"],
  );

  Map<String, dynamic> toMap() => {
    "kode_saham": kodeSaham,
    "potensi_kenaikan": potensiKenaikan,
    "fundamental": fundamental,
    "teknikal": teknikal,
    "sentimen": sentimen,
    "beli": beli,
    "jual": jual,
  };
}
