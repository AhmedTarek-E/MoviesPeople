import 'package:equatable/equatable.dart';
import 'package:movies_people/people/domain/models/pagination_data.dart';
import 'package:movies_people/people/domain/models/person_info.dart';
import 'package:movies_people/utils/async.dart';

class PopularPeopleState extends Equatable {
  final String? errorMessage;
  final Async<PaginationData<PersonInfo>> popularPeople;

  const PopularPeopleState(this.errorMessage, this.popularPeople,);

  const PopularPeopleState.initial() : this(
    null,
    const Async.initial(),
  );

  PopularPeopleState reduce({
    String? errorMessage,
    Async<PaginationData<PersonInfo>>? popularPeople,
  }) {
    return PopularPeopleState(
      errorMessage,
      popularPeople ?? this.popularPeople,
    );
  }

  @override
  List<Object?> get props => [
    errorMessage,
    popularPeople,
  ];
}
