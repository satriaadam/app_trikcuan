import 'dart:convert';

List<RecomendationModel> recomendationModelFromMap(String str) => List<RecomendationModel>.from(json.decode(str).map((x) => RecomendationModel.fromMap(x)));

String recomendationModelToMap(List<RecomendationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class RecomendationModel {
    RecomendationModel({
        this.id,
        this.kodeSaham,
        this.potensiKenaikan,
        this.fundamental,
        this.prospekPerusahaan,
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
    String prospekPerusahaan;
    String teknikal;
    String sentimen;
    String beli;
    String jual;
    String hargaBeli;

    factory RecomendationModel.fromMap(Map<String, dynamic> json) => RecomendationModel(
        id: json["id"],
        kodeSaham: json["kode_saham"],
        potensiKenaikan: json["potensi_kenaikan"],
        fundamental: json["fundamental"],
        prospekPerusahaan: json["prospek_perusahaan"],
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
        "prospek_perusahaan": prospekPerusahaan,
        "teknikal": teknikal,
        "sentimen": sentimen,
        "beli": beli,
        "jual": jual,
        "harga_beli": hargaBeli,
    };
}
