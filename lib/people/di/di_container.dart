
import 'package:movies_people/people/domain/use_cases/popular_people_use_case.dart';

class DiContainer {
  DiContainer._();

  static PopularPeopleUseCase getPopularPeopleUseCase() {
    return PopularPeopleUseCase();
  }
}