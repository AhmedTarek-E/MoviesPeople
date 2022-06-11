
import 'package:movies_people/people/domain/models/person_details.dart';
import 'package:movies_people/people/domain/repositories/people_repository.dart';

class PersonDetailsUseCase {
  final PeopleRepository _repository;

  PersonDetailsUseCase(this._repository);

  Future<PersonDetails> execute(int id) async {
    return _repository.getPersonDetails(id);
  }

}