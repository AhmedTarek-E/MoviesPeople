import 'package:movies_people/people/data/data_sources/api_models/popular_people/api_popular_people_result.dart';
import 'package:movies_people/people/domain/models/person_info.dart';
import 'package:movies_people/utils/extensions.dart';

extension PersonMapper on PersonResult {
  PersonInfo? map() {
    if (id == null) return null;
    return PersonInfo(
      id!,
      name ?? "",
      profilePath != null ? 'https://image.tmdb.org/t/p/w185$profilePath' : "",
      knownFor?.firstOrNull()?.title ?? "",
    );
  }
}