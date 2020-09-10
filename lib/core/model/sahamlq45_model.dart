import 'dart:convert';

List<SahamLQ45Model> sahamlq45ModelFromMap(String str) => List<SahamLQ45Model>.from(json.decode(str).map((x) => SahamLQ45Model.fromMap(x)));

String sahamlq45ModelToMap(List<SahamLQ45Model> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class SahamLQ45Model {
  SahamLQ45Model({
    this.id,
    this.kodeSaham,
    this.potensiKenaikan,
    this.fundamental,
    this.teknikal,
    this.sentimen,
    this.beli,
    this.jual,
    this.hargaBeli,
  });

  int id;
  String kodeSaham;
  String potensiKenaikan;
  String fundamental;
  String teknikal;
  String sentimen;
  String beli;
  String jual;
  String hargaBeli;

  factory SahamLQ45Model.fromMap(Map<String, dynamic> json) => SahamLQ45Model(
    id: json["id"],
    kodeSaham: json["kode_saham"],
    potensiKenaikan: json["potensi_kenaikan"],
    fundamental: json["fundamental"],
    teknikal: json["teknikal"],
    sentimen: json["sentimen"],
    beli: json["beli"],
    jual: json["jual"],
    hargaBeli: json["harga_beli"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "kode_saham": kodeSaham,
    "potensi_kenaikan": potensiKenaikan,
    "fundamental": fundamental,
    "teknikal": teknikal,
    "sentimen": sentimen,
    "beli": beli,
    "jual": jual,
    "harga_beli": hargaBeli,
  };
}
