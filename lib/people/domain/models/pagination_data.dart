import 'package:equatable/equatable.dart';
import 'package:movies_people/people/domain/models/page_info.dart';

class PaginationData<T> extends Equatable {
  final List<T> data;
  final PageInfo pageInfo;

  const PaginationData(this.data, this.pageInfo);

  @override
  List<Object?> get props => [
    data,
    pageInfo,
  ];
}