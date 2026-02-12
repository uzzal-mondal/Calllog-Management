// To parse this JSON data, do
//
//     final aboutUsModel = aboutUsModelFromJson(jsonString);

import 'dart:convert';

AboutUsModel aboutUsModelFromJson(String str) => AboutUsModel.fromJson(json.decode(str));

String aboutUsModelToJson(AboutUsModel data) => json.encode(data.toJson());

class AboutUsModel {
    String? title;
    String? toolbarTitle;
    String? content;

    AboutUsModel({
        this.title,
        this.toolbarTitle,
        this.content,
    });

    factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
        title: json["Title"],
        toolbarTitle: json["ToolbarTitle"],
        content: json["Content"],
    );

    Map<String, dynamic> toJson() => {
        "Title": title,
        "ToolbarTitle": toolbarTitle,
        "Content": content,
    };
}
