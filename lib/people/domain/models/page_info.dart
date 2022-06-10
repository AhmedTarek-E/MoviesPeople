import 'package:equatable/equatable.dart';

class PageInfo extends Equatable {
  final int page;
  final int totalPages;

  bool get hasNext => page < totalPages;

  const PageInfo(this.page, this.totalPages);

  @override
  List<Object?> get props => [
    page,
    totalPages
  ];

}