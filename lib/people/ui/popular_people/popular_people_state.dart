import 'package:equatable/equatable.dart';

class PopularPeopleState extends Equatable {
  final String? errorMessage;

  const PopularPeopleState(this.errorMessage);

  const PopularPeopleState.initial() : this(
    null,
  );

  @override
  List<Object?> get props => [];
}
