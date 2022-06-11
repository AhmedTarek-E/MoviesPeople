import 'package:movies_people/people/data/data_sources/api_models/person_details/api_person_details_result.dart';
import 'package:movies_people/people/domain/models/person_details.dart';
import 'package:movies_people/people/domain/models/person_info.dart';

extension PersonDetailsMapper on ApiPersonDetailsResult {
  PersonDetails map(List<String> images) {
    return PersonDetails(
      PersonInfo(
        id ?? -1,
        name ?? "",
        profilePath != null ? 'https://image.tmdb.org/t/p/w185$profilePath' : "",
        ""
      ),
      biography ?? "",
      birthday ?? "",
      placeOfBirth ?? "",
      images,
    );
  }
}