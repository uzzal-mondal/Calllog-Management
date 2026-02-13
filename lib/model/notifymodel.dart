// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

List<NotificationModel> notificationModelFromJson(String str) => List<NotificationModel>.from(json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
    int? id;
    String? title;
    String? message;
    String? url;
    dynamic icon;
    DateTime? visibilityStart;
    DateTime? visibilityEnd;

    NotificationModel({
        this.id,
        this.title,
        this.message,
        this.url,
        this.icon,
        this.visibilityStart,
        this.visibilityEnd,
    });

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["Id"],
        title: json["Title"],
        message: json["Message"],
        url: json["Url"],
        icon: json["Icon"],
        visibilityStart: json["VisibilityStart"] == null ? null : DateTime.parse(json["VisibilityStart"]),
        visibilityEnd: json["VisibilityEnd"] == null ? null : DateTime.parse(json["VisibilityEnd"]),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
        "Message": message,
        "Url": url,
        "Icon": icon,
        "VisibilityStart": visibilityStart?.toIso8601String(),
        "VisibilityEnd": visibilityEnd?.toIso8601String(),
    };
}
