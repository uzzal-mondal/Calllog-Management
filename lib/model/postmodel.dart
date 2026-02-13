import 'dart:convert';

PostResponse postResponseFromJson(String str) =>
    PostResponse.fromJson(json.decode(str));

String postResponseToJson(PostResponse data) => json.encode(data.toJson());

class PostResponse {
  List<PostItem> posts;
  Pages pages;

  PostResponse({required this.posts, required this.pages});

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      posts: json["posts"] == null
          ? []
          : List<PostItem>.from(json["posts"].map((x) => PostItem.fromJson(x))),
      pages: Pages.fromJson(json["pages"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
    "pages": pages.toJson(),
  };
}

class PostItem {
  int id;
  String title;
  String slug;
  String postType;
  String content;
  String? fileName;
  String? filePath;
  String? fileType;
  DateTime createdAt;

  PostItem({
    required this.id,
    required this.title,
    required this.slug,
    required this.postType,
    required this.content,
    this.fileName,
    this.filePath,
    this.fileType,
    required this.createdAt,
  });

  factory PostItem.fromJson(Map<String, dynamic> json) {
    return PostItem(
      id: json["Id"] ?? 0,
      title: json["Title"] ?? '',
      slug: json["Slug"] ?? '',
      postType: json["PostType"] ?? '',
      content: json["Content"] ?? '',
      fileName: json["FileName"],
      filePath: json["FilePath"],
      fileType: json["FileType"],
      createdAt: DateTime.tryParse(json["CreatedAt"] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Title": title,
    "Slug": slug,
    "PostType": postType,
    "Content": content,
    "FileName": fileName,
    "FilePath": filePath,
    "FileType": fileType,
    "CreatedAt": createdAt.toIso8601String(),
  };
}

class Pages {
  int totalRecords;
  int totalPages;
  int pageSize;

  Pages({
    required this.totalRecords,
    required this.totalPages,
    required this.pageSize,
  });

  factory Pages.fromJson(Map<String, dynamic> json) {
    return Pages(
      totalRecords: json["TotalRecords"] ?? 0,
      totalPages: json["TotalPages"] ?? 0,
      pageSize: json["PageSize"] ?? 10,
    );
  }

  Map<String, dynamic> toJson() => {
    "TotalRecords": totalRecords,
    "TotalPages": totalPages,
    "PageSize": pageSize,
  };
}
