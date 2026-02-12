// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'dart:convert';

List<FaqModel> faqModelFromJson(String str) => List<FaqModel>.from(json.decode(str).map((x) => FaqModel.fromJson(x)));

String faqModelToJson(List<FaqModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FaqModel {
    int? id;
    String? question;
    String? answer;

    FaqModel({
        this.id,
        this.question,
        this.answer,
    });

    factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        id: json["Id"],
        question: json["Question"],
        answer: json["Answer"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Question": question,
        "Answer": answer,
    };
}
