import 'package:equatable/equatable.dart';

class PersonInfo extends Equatable {
  final int id;
  final String name;
  final String profilePicture;

  const PersonInfo(
    this.id,
    this.name,
    this.profilePicture,
  );

  @override
  List<Object?> get props => [
    id,
    name,
    profilePicture,
  ];
}
