import 'dart:convert';

import 'package:movies_people/people/data/data_sources/api_models/popular_people/api_popular_people_result.dart';
import 'package:http/http.dart' as http;

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
      throw Exception("Failed to load course details");
    }
  }
}