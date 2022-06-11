import 'package:movies_people/people/data/data_sources/people_data_source.dart';
import 'package:movies_people/people/data/repositories/mappers/person_details_mapper.dart';
import 'package:movies_people/people/data/repositories/mappers/person_mapper.dart';
import 'package:movies_people/people/domain/models/page_info.dart';
import 'package:movies_people/people/domain/models/pagination_data.dart';
import 'package:movies_people/people/domain/models/person_details.dart';
import 'package:movies_people/people/domain/models/person_info.dart';
import 'package:movies_people/people/domain/repositories/people_repository.dart';
import 'package:movies_people/utils/extensions.dart';

class PeopleRepositoryImp implements PeopleRepository {
  final PeopleDataSource dataSource;

  PeopleRepositoryImp(this.dataSource);

  @override
  Future<PaginationData<PersonInfo>> getPopularPeople(int page) async {
    final result = await dataSource.getPopularPeople(page);
    final pageInfo = PageInfo(
      result.page ?? page,
      result.totalPages ?? 0,
    );
    final data = result.results;
    if (data != null) {
      return PaginationData(
        data.mapNotNull((e) => e.map()).toList(),
        pageInfo,
      );
    } else {
      throw Exception("No data found");
    }
  }

  @override
  Future<PersonDetails> getPersonDetails(int personId) async {
    final result = await dataSource.getPersonDetails(personId);
    final imagesResult = await dataSource.getPersonImages(personId);
    final images = imagesResult.profiles?.map((e) {
      return "https://image.tmdb.org/t/p/w185${e.filePath}";
    }).toList() ?? [];
    return result.map(images);
  }

}