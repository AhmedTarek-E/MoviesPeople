
import 'package:movies_people/people/data/data_sources/people_data_source.dart';
import 'package:movies_people/people/data/repositories/people_repository_imp.dart';
import 'package:movies_people/people/domain/use_cases/popular_people_use_case.dart';

class DiContainer {
  DiContainer._();

  static PeopleDataSource? _peopleDataSource;
  static PeopleDataSource getPeopleDataSource() {
    _peopleDataSource ??= PeopleDataSource();
    return _peopleDataSource!;
  }

  static PopularPeopleUseCase getPopularPeopleUseCase() {
    return PopularPeopleUseCase(
      PeopleRepositoryImp(
        getPeopleDataSource(),
      ),
    );
  }
}