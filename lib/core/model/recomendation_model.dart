import 'dart:convert';

List<RecomendationModel> recomendationModelFromMap(String str) => List<RecomendationModel>.from(json.decode(str).map((x) => RecomendationModel.fromMap(x)));

String recomendationModelToMap(List<RecomendationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

RecomendationModel recomendationDetailFromMap(String str) => RecomendationModel.fromMap(json.decode(str));

String recomendationDetailToMap(RecomendationModel data) => json.encode(data.toMap());

class RecomendationModel {
    RecomendationModel({
        this.id,
        this.kodeSaham,
        this.kategori,
        this.potensiKenaikan,
        this.fundamental,
        this.prospekPerusahaan,
        this.teknikal,
        this.jualBeli,
        this.date,
        this.hargaBeli,
    });

    int id;
    String kodeSaham;
    String kategori;
    String potensiKenaikan;
    String prospekPerusahaan;
    String fundamental;
    String teknikal;
    String jualBeli;
    String date;
    String hargaBeli;

    factory RecomendationModel.fromMap(Map<String, dynamic> json) => RecomendationModel(
        id: json["id"],
        kodeSaham: json["kode_saham"]?.toString() ?? "",
        kategori: json["kategori"]?.toString() ?? "",
        potensiKenaikan: json["potensi_kenaikan"]?.toString() ?? "",
        prospekPerusahaan: json["prospek_perusahaan"]?.toString() ?? "",
        fundamental: json["fundamental"]?.toString() ?? "",
        teknikal: json["teknikal"]?.toString() ?? "",
        jualBeli: json["jual_beli"]?.toString() ?? "0",
        date: json["date"],
        hargaBeli: json["harga_beli"]?.toString() ?? "0",
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "kode_saham": kodeSaham,
        "kategori": kategori,
        "potensi_kenaikan": potensiKenaikan,
        "prospek_perusahaan": prospekPerusahaan,
        "fundamental": fundamental,
        "teknikal": teknikal,
        "jual_beli": jualBeli,
        "date": date,
        "harga_beli": hargaBeli,
    };
}

class RecomendationPost {
    RecomendationPost({
        this.kategori,
        this.kodeSaham,
        this.potensiKenaikan,
        this.fundamental,
        this.prospekPerusahaan,
        this.teknikal,
        this.jualBeli,
        this.hargaBeli,
        this.date,
    });

    String kategori;
    String kodeSaham;
    String potensiKenaikan;
    String prospekPerusahaan;
    String fundamental;
    String teknikal;
    String jualBeli;
    String hargaBeli;
    String date;

    Map<String, dynamic> toMap() => {
        "kategori": kategori,
        "kode_saham": kodeSaham,
        "potensi_kenaikan": potensiKenaikan,
        "prospek_perusahaan": prospekPerusahaan,
        "fundamental": fundamental,
        "teknikal": teknikal,
        "jual_beli": jualBeli,
        "harga_beli": hargaBeli,
        "date": date,
    };
}
