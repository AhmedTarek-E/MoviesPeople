import 'package:equatable/equatable.dart';
import 'package:movies_people/people/domain/models/person_info.dart';

class PersonDetails extends Equatable {
  final PersonInfo info;
  final String biography;
  final String birthday;
  final String placeOfBirth;
  final List<String> images;

  const PersonDetails(
    this.info,
    this.biography,
    this.birthday,
    this.placeOfBirth,
    this.images,
  );

  @override
  List<Object?> get props => [
    info,
    biography,
    birthday,
    placeOfBirth,
    images,
  ];
}