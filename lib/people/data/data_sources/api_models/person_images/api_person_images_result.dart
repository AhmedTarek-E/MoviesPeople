// To parse this JSON data, do
//
//     final apiPersonImagesResult = apiPersonImagesResultFromJson(jsonString);

import 'dart:convert';

ApiPersonImagesResult apiPersonImagesResultFromJson(String str) => ApiPersonImagesResult.fromJson(json.decode(str));

String apiPersonImagesResultToJson(ApiPersonImagesResult data) => json.encode(data.toJson());

class ApiPersonImagesResult {
  ApiPersonImagesResult({
    this.id,
    this.profiles,
  });

  int? id;
  List<Profile>? profiles;

  factory ApiPersonImagesResult.fromJson(Map<String, dynamic> json) => ApiPersonImagesResult(
    id: json["id"],
    profiles: json["profiles"] == null ? null : List<Profile>.from(json["profiles"].map((x) => Profile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profiles": profiles == null ? null : List<dynamic>.from(profiles!.map((x) => x.toJson())),
  };
}

class Profile {
  Profile({
    this.filePath,
  });

  String? filePath;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    filePath: json["file_path"],
  );

  Map<String, dynamic> toJson() => {
    "file_path": filePath,
  };
}
