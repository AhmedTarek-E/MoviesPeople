// To parse this JSON data, do
//
//     final apiPopularPeopleResult = apiPopularPeopleResultFromJson(jsonString);

import 'dart:convert';

ApiPopularPeopleResult apiPopularPeopleResultFromJson(String str) => ApiPopularPeopleResult.fromJson(json.decode(str));

String apiPopularPeopleResultToJson(ApiPopularPeopleResult data) => json.encode(data.toJson());

class ApiPopularPeopleResult {
  ApiPopularPeopleResult({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int? page;
  List<PersonResult>? results;
  int? totalPages;
  int? totalResults;

  factory ApiPopularPeopleResult.fromJson(Map<String, dynamic> json) => ApiPopularPeopleResult(
    page: json["page"],
    results: json["results"] == null ? null : List<PersonResult>.from(json["results"].map((x) => PersonResult.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": results == null ? null : List<dynamic>.from(results!.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class PersonResult {
  PersonResult({
    this.id,
    this.knownFor,
    this.name,
    this.profilePath,
  });

  int? id;
  List<KnownFor>? knownFor;
  String? name;
  String? profilePath;

  factory PersonResult.fromJson(Map<String, dynamic> json) => PersonResult(
    id: json["id"],
    knownFor: json["known_for"] == null ? null : List<KnownFor>.from(json["known_for"].map((x) => KnownFor.fromJson(x))),
    name: json["name"],
    profilePath: json["profile_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "known_for": knownFor == null ? null : List<dynamic>.from(knownFor!.map((x) => x.toJson())),
    "name": name,
    "profile_path": profilePath,
  };
}

class KnownFor {
  KnownFor({
    this.title,
  });


  String? title;

  factory KnownFor.fromJson(Map<String, dynamic> json) => KnownFor(
    title: json["title"] ?? json["name"],
  );

  Map<String, dynamic> toJson() => {
    "original_title": title,
  };
}