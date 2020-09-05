import 'dart:convert';

List<NewsModel> newsModelFromMap(String str) => List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromMap(x)));

String newsModelToMap(List<NewsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class NewsModel {
    NewsModel({
        this.id,
        this.title,
        this.link,
    });

    int id;
    String title;
    String link;

    factory NewsModel.fromMap(Map<String, dynamic> json) => NewsModel(
        id: json["id"],
        title: json["title"],
        link: json["link"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "link": link,
    };
}