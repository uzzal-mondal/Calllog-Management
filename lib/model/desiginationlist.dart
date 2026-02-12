// To parse this JSON data, do
//
//     final designationList = designationListFromJson(jsonString);

import 'dart:convert';

List<DesignationList> designationListFromJson(String str) => List<DesignationList>.from(json.decode(str).map((x) => DesignationList.fromJson(x)));

String designationListToJson(List<DesignationList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DesignationList {
    int? id;
    String? name;

    DesignationList({
        this.id,
        this.name,
    });

    factory DesignationList.fromJson(Map<String, dynamic> json) => DesignationList(
        id: json["Id"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
    };
}
