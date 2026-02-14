// To parse this JSON data, do
//
//     final projectIssueModel = projectIssueModelFromJson(jsonString);

import 'dart:convert';

List<ProjectIssueModel> projectIssueModelFromJson(String str) =>
    List<ProjectIssueModel>.from(
      json.decode(str).map((x) => ProjectIssueModel.fromJson(x)),
    );

String projectIssueModelToJson(List<ProjectIssueModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectIssueModel {
  int? issueId;
  int? sectionId;
  int? milestoneId;
  String? title;
  String? description;
  dynamic files;
  dynamic images;
  int? issuePriorityId;
  int? issueWeightId;
  double? weight; // fixed: now double to handle decimal values
  int? issueStatusId;
  dynamic createdByUserId;
  dynamic ownerUserId;
  dynamic dueDate;
  dynamic closedByUserId;
  dynamic closedAt;
  bool? mailSend;

  ProjectIssueModel({
    this.issueId,
    this.sectionId,
    this.milestoneId,
    this.title,
    this.description,
    this.files,
    this.images,
    this.issuePriorityId,
    this.issueWeightId,
    this.weight,
    this.issueStatusId,
    this.createdByUserId,
    this.ownerUserId,
    this.dueDate,
    this.closedByUserId,
    this.closedAt,
    this.mailSend,
  });

  factory ProjectIssueModel.fromJson(Map<String, dynamic> json) =>
      ProjectIssueModel(
        issueId: json["IssueId"],
        sectionId: json["SectionId"],
        milestoneId: json["MilestoneId"],
        title: json["Title"],
        description: json["Description"],
        files: json["Files"],
        images: json["Images"],
        // safely convert to int if double
        issuePriorityId: json["IssuePriorityId"] is int
            ? json["IssuePriorityId"]
            : (json["IssuePriorityId"] as double?)?.toInt(),
        issueWeightId: json["IssueWeightId"] is int
            ? json["IssueWeightId"]
            : (json["IssueWeightId"] as double?)?.toInt(),
        // convert weight to double safely
        weight: json["Weight"] is int
            ? (json["Weight"] as int).toDouble()
            : json["Weight"] as double?,
        issueStatusId: json["IssueStatusId"],
        createdByUserId: json["CreatedByUserId"],
        ownerUserId: json["OwnerUserId"],
        dueDate: json["DueDate"],
        closedByUserId: json["ClosedByUserId"],
        closedAt: json["ClosedAt"],
        mailSend: json["MailSend"],
      );

  Map<String, dynamic> toJson() => {
    "IssueId": issueId,
    "SectionId": sectionId,
    "MilestoneId": milestoneId,
    "Title": title,
    "Description": description,
    "Files": files,
    "Images": images,
    "IssuePriorityId": issuePriorityId,
    "IssueWeightId": issueWeightId,
    "Weight": weight,
    "IssueStatusId": issueStatusId,
    "CreatedByUserId": createdByUserId,
    "OwnerUserId": ownerUserId,
    "DueDate": dueDate,
    "ClosedByUserId": closedByUserId,
    "ClosedAt": closedAt,
    "MailSend": mailSend,
  };
}
