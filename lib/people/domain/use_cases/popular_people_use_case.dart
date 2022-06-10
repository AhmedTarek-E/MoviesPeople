
import 'package:movies_people/people/domain/models/pagination_data.dart';
import 'package:movies_people/people/domain/models/person_info.dart';
import 'package:movies_people/people/domain/repositories/people_repository.dart';

class PopularPeopleUseCase {
  final PeopleRepository _repository;

  PopularPeopleUseCase(this._repository);

  Future<PaginationData<PersonInfo>> execute(int page) async {
    return _repository.getPopularPeople(page);
  }
}