import 'dart:convert';

import 'package:movies_people/people/data/data_sources/api_models/person_images/api_person_images_result.dart';
import 'package:movies_people/people/data/data_sources/api_models/popular_people/api_popular_people_result.dart';
import 'package:http/http.dart' as http;

import 'api_models/person_details/api_person_details_result.dart';

class PeopleDataSource {
  Future<ApiPopularPeopleResult> getPopularPeople(int page) async {
    final uri = Uri.https(
      "api.themoviedb.org",
      "/3/person/popular",
      {
        //TODO move it to secret file
        "api_key" : "e18ed3c4e9cd605d7041d7c6888aea84",
        "language" : "en-US",
        "page": page.toString()
      }
    );

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return ApiPopularPeopleResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load people");
    }
  }

  Future<ApiPersonDetailsResult> getPersonDetails(int personId) async {
    final uri = Uri.https(
        "api.themoviedb.org",
        "/3/person/$personId",
        {
          //TODO move it to secret file
          "api_key" : "e18ed3c4e9cd605d7041d7c6888aea84",
          "language" : "en-US",
        }
    );

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return ApiPersonDetailsResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load person details");
    }
  }

  Future<ApiPersonImagesResult> getPersonImages(int personId) async {
    final uri = Uri.https(
        "api.themoviedb.org",
        "/3/person/$personId/images",
        {
          //TODO move it to secret file
          "api_key" : "e18ed3c4e9cd605d7041d7c6888aea84",
        }
    );

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return ApiPersonImagesResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load person images");
    }
  }
}