// To parse this JSON data, do
//
//     final apiPersonDetailsResult = apiPersonDetailsResultFromJson(jsonString);

import 'dart:convert';

ApiPersonDetailsResult apiPersonDetailsResultFromJson(String str) => ApiPersonDetailsResult.fromJson(json.decode(str));

String apiPersonDetailsResultToJson(ApiPersonDetailsResult data) => json.encode(data.toJson());

class ApiPersonDetailsResult {
  ApiPersonDetailsResult({
    this.biography,
    this.birthday,
    this.id,
    this.name,
    this.placeOfBirth,
    this.profilePath,
  });

  String? biography;
  String? birthday;
  int? id;
  String? name;
  String? placeOfBirth;
  String? profilePath;

  factory ApiPersonDetailsResult.fromJson(Map<String, dynamic> json) => ApiPersonDetailsResult(
    biography: json["biography"],
    birthday: json["birthday"],
    id: json["id"],
    name: json["name"],
    placeOfBirth: json["place_of_birth"],
    profilePath: json["profile_path"],
  );

  Map<String, dynamic> toJson() => {
    "biography": biography,
    "birthday": birthday,
    "id": id,
    "name": name,
    "place_of_birth": placeOfBirth,
    "profile_path": profilePath,
  };
}
