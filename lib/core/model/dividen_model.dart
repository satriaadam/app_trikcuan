import 'dart:convert';

List<DividenModel> dividenModelFromMap(String str) => List<DividenModel>.from(json.decode(str).map((x) => DividenModel.fromMap(x)));

String dividenModelToMap(List<DividenModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class DividenModel {
  DividenModel({
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

  factory DividenModel.fromMap(Map<String, dynamic> json) => DividenModel(
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
