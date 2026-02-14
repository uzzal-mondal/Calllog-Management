import 'dart:convert';

// ----------------- Issue Details Model -----------------
IssueDetailsModel issueDetailsModelFromJson(String str) =>
    IssueDetailsModel.fromJson(json.decode(str));

String issueDetailsModelToJson(IssueDetailsModel data) =>
    json.encode(data.toJson());

class IssueDetailsModel {
  Issue? issue;
  List<Label>? labels;
  List<Assignee>? assignee;

  // Master data for dropdowns
  List<MasterData>? projects;
  List<MasterData>? priorities;
  List<MasterData>? statuses;
  List<MasterData>? sections;
  List<MasterData>? milestones;

  IssueDetailsModel({
    this.issue,
    this.labels,
    this.assignee,
    this.projects,
    this.priorities,
    this.statuses,
    this.sections,
    this.milestones,
  });

  factory IssueDetailsModel.fromJson(Map<String, dynamic> json) =>
      IssueDetailsModel(
        issue: json["issue"] == null ? null : Issue.fromJson(json["issue"]),
        labels: json["labels"] == null
            ? []
            : List<Label>.from(json["labels"].map((x) => Label.fromJson(x))),
        assignee: json["assignee"] == null
            ? []
            : List<Assignee>.from(
                json["assignee"].map((x) => Assignee.fromJson(x))),
        projects: json["projects"] == null
            ? []
            : List<MasterData>.from(
                json["projects"].map((x) => MasterData.fromJson(x))),
        priorities: json["priorities"] == null
            ? []
            : List<MasterData>.from(
                json["priorities"].map((x) => MasterData.fromJson(x))),
        statuses: json["statuses"] == null
            ? []
            : List<MasterData>.from(
                json["statuses"].map((x) => MasterData.fromJson(x))),
        sections: json["sections"] == null
            ? []
            : List<MasterData>.from(
                json["sections"].map((x) => MasterData.fromJson(x))),
        milestones: json["milestones"] == null
            ? []
            : List<MasterData>.from(
                json["milestones"].map((x) => MasterData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "issue": issue?.toJson(),
        "labels":
            labels == null ? [] : List<dynamic>.from(labels!.map((x) => x.toJson())),
        "assignee": assignee == null
            ? []
            : List<dynamic>.from(assignee!.map((x) => x.toJson())),
        "projects":
            projects == null ? [] : List<dynamic>.from(projects!.map((x) => x.toJson())),
        "priorities": priorities == null
            ? []
            : List<dynamic>.from(priorities!.map((x) => x.toJson())),
        "statuses": statuses == null
            ? []
            : List<dynamic>.from(statuses!.map((x) => x.toJson())),
        "sections": sections == null
            ? []
            : List<dynamic>.from(sections!.map((x) => x.toJson())),
        "milestones": milestones == null
            ? []
            : List<dynamic>.from(milestones!.map((x) => x.toJson())),
      };
}

// ----------------- Issue -----------------
class Issue {
  int? issueId;
  int? projectId;
  int? sectionId;
  int? milestoneId;
  String? title;
  String? description;
  int? issuePriorityId;
  int? issueStatusId;
  int? weight;
  String? statusName;
  String? createdByName;
  String? ownerName;
  String? dueDate;
  String? closedAt;

  Issue({
    this.issueId,
    this.projectId,
    this.sectionId,
    this.milestoneId,
    this.title,
    this.description,
    this.issuePriorityId,
    this.issueStatusId,
    this.weight,
    this.statusName,
    this.createdByName,
    this.ownerName,
    this.dueDate,
    this.closedAt,
  });

  factory Issue.fromJson(Map<String, dynamic> json) => Issue(
        issueId: json["IssueId"],
        projectId: json["ProjectId"],
        sectionId: json["SectionId"],
        milestoneId: json["MilestoneId"],
        title: json["Title"],
        description: json["Description"],
        issuePriorityId: json["IssuePriorityId"],
        issueStatusId: json["IssueStatusId"],
        weight: json["Weight"],
        statusName: json["StatusName"],
        createdByName: json["CreatedByName"],
        ownerName: json["OwnerName"],
        dueDate: json["DueDate"],
        closedAt: json["ClosedAt"],
      );

  Map<String, dynamic> toJson() => {
        "IssueId": issueId,
        "ProjectId": projectId,
        "SectionId": sectionId,
        "MilestoneId": milestoneId,
        "Title": title,
        "Description": description,
        "IssuePriorityId": issuePriorityId,
        "IssueStatusId": issueStatusId,
        "Weight": weight,
        "StatusName": statusName,
        "CreatedByName": createdByName,
        "OwnerName": ownerName,
        "DueDate": dueDate,
        "ClosedAt": closedAt,
      };
}

// ----------------- Label -----------------
class Label {
  int? id;
  String? name;

  Label({this.id, this.name});

  factory Label.fromJson(Map<String, dynamic> json) =>
      Label(id: json["Id"], name: json["Name"]);

  Map<String, dynamic> toJson() => {"Id": id, "Name": name};
}

// ----------------- Assignee -----------------
class Assignee {
  int? userId;
  String? name;

  Assignee({this.userId, this.name});

  factory Assignee.fromJson(Map<String, dynamic> json) =>
      Assignee(userId: json["UserId"], name: json["Name"]);

  Map<String, dynamic> toJson() => {"UserId": userId, "Name": name};
}

// ----------------- Master Data -----------------
class MasterData {
  int? id;
  String? name;

  MasterData({this.id, this.name});

  factory MasterData.fromJson(Map<String, dynamic> json) =>
      MasterData(id: json["Id"], name: json["Name"]);

  Map<String, dynamic> toJson() => {"Id": id, "Name": name};
}