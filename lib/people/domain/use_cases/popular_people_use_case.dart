
import 'package:movies_people/people/domain/models/page_info.dart';
import 'package:movies_people/people/domain/models/pagination_data.dart';
import 'package:movies_people/people/domain/models/person_info.dart';

class PopularPeopleUseCase {

  Future<PaginationData<PersonInfo>> execute(int page) async {
    return const PaginationData(
      [
        PersonInfo(0, "Johnny Depp", ""),
        PersonInfo(1, "Amber Heard", ""),
      ],
      PageInfo(1, 500),
    );
  }
}