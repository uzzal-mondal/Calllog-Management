// To parse this JSON data, do
//
//     final portfolioModel = portfolioModelFromJson(jsonString);

import 'dart:convert';

List<PortfolioModel> portfolioModelFromJson(String str) =>
    List<PortfolioModel>.from(
      json.decode(str).map((x) => PortfolioModel.fromJson(x)),
    );

String portfolioModelToJson(List<PortfolioModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PortfolioModel {
  String? name;
  String? code;
  String? description;
  String? image;

  PortfolioModel({this.name, this.code, this.description, this.image});

  factory PortfolioModel.fromJson(Map<String, dynamic> json) => PortfolioModel(
    name: json["Name"],
    code: json["Code"],
    description: json["Description"],
    image: json["Image"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Code": code,
    "Description": description,
    "Image": image,
  };
}
