
import 'package:movies_people/people/domain/models/page_info.dart';
import 'package:movies_people/people/domain/models/pagination_data.dart';
import 'package:movies_people/people/domain/models/person_info.dart';

class PopularPeopleUseCase {

  Future<PaginationData<PersonInfo>> execute(int page) async {
    return const PaginationData(
      [
        PersonInfo(
          0,
          "Johnny Depp",
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStpy5AJ7T5ogRTjgXmakPRf0SaxtG5fA-7YtfI7aqZKjBCSi7R",
          "Public Enemy",
        ),
        PersonInfo(
          1,
          "Amber Heard",
          "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQGdtrXX9rt3Nr-mwNuBP6nGFngQ3u6OtquCbeJOOLP6IZgI6nN",
          "Aquaman",
        ),
      ],
      PageInfo(1, 500),
    );
  }
}