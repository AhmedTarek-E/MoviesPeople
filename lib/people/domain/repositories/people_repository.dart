import 'package:movies_people/people/domain/models/pagination_data.dart';
import 'package:movies_people/people/domain/models/person_details.dart';
import 'package:movies_people/people/domain/models/person_info.dart';

abstract class PeopleRepository {
  Future<PaginationData<PersonInfo>> getPopularPeople(int page);
  Future<PersonDetails> getPersonDetails(int personId);
}