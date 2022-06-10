import 'package:equatable/equatable.dart';

class PersonInfo extends Equatable {
  final int id;
  final String name;
  final String profilePicture;
  final String knownForTitle;

  const PersonInfo(
    this.id,
    this.name,
    this.profilePicture,
    this.knownForTitle,
  );

  @override
  List<Object?> get props => [
    id,
    name,
    profilePicture,
    knownForTitle,
  ];
}
