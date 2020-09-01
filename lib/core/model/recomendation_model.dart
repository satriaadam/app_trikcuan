import 'dart:convert';

List<RecomendationModel> recomendationModelFromMap(String str) => List<RecomendationModel>.from(json.decode(str).map((x) => RecomendationModel.fromMap(x)));

String recomendationModelToMap(List<RecomendationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class RecomendationModel {
    RecomendationModel({
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

    factory RecomendationModel.fromMap(Map<String, dynamic> json) => RecomendationModel(
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
