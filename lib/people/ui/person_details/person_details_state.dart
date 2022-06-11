import 'package:equatable/equatable.dart';
import 'package:movies_people/people/domain/models/person_details.dart';
import 'package:movies_people/utils/async.dart';

class PersonDetailsState extends Equatable {
  final String? errorMessage;
  final Async<PersonDetails> personDetails;

  const PersonDetailsState(
    this.errorMessage,
    this.personDetails,
  );

  const PersonDetailsState.initial() : this(
    null,
    const Async.initial(),
  );

  PersonDetailsState reduce({
    String? errorMessage,
    Async<PersonDetails>? personDetails
  }) {
    return PersonDetailsState(
      errorMessage,
      personDetails ?? this.personDetails,
    );
  }

  @override
  List<Object?> get props => [
    errorMessage,
    personDetails,
  ];
}
