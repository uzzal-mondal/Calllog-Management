import 'dart:convert';

ProjectModel projectModelFromJson(String str) =>
    ProjectModel.fromJson(json.decode(str));

class ProjectModel {
  List<Project>? projects;

  ProjectModel({this.projects});

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
    projects: json["projects"] == null
        ? []
        : List<Project>.from(json["projects"].map((x) => Project.fromJson(x))),
  );
}

class Project {
  int? projectId;
  String? code;
  String? name;
  String? description;

  Project({this.projectId, this.code, this.name, this.description});

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    projectId: json["ProjectId"],
    code: json["Code"],
    name: json["Name"],
    description: json["Description"],
  );
}
