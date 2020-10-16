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
        kodeSaham: json["kode_saham"]?.toString() ?? "",
        potensiKenaikan: json["potensi_kenaikan"]?.toString() ?? "",
        prospekPerusahaan: json["prospek_perusahaan"]?.toString() ?? "",
        fundamental: json["fundamental"]?.toString() ?? "",
        teknikal: json["teknikal"]?.toString() ?? "",
        jualBeli: json["jual_beli"]?.toString() ?? "0",
        hargaBeli: json["harga_beli"]?.toString() ?? "0",
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
