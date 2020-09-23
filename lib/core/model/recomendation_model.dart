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
        this.jualBeli,
        this.hargaBeli,
    });

    int id;
    String kodeSaham;
    String potensiKenaikan;
    String prospekPerusahaan;
    String fundamental;
    String teknikal;
    String jualBeli;
    String hargaBeli;

    factory RecomendationModel.fromMap(Map<String, dynamic> json) => RecomendationModel(
        id: json["id"],
        kodeSaham: json["kode_saham"] ?? "",
        potensiKenaikan: json["potensi_kenaikan"] ?? "",
        prospekPerusahaan: json["prospek_perusahaan"] ?? "",
        fundamental: json["fundamental"] ?? "",
        teknikal: json["teknikal"] ?? "",
        jualBeli: json["jual_beli"] ?? "",
        hargaBeli: json["harga_beli"] ?? "0",
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "kode_saham": kodeSaham,
        "potensi_kenaikan": potensiKenaikan,
        "prospek_perusahaan": prospekPerusahaan,
        "fundamental": fundamental,
        "teknikal": teknikal,
        "jual_beli": jualBeli,
        "harga_beli": hargaBeli,
    };
}
