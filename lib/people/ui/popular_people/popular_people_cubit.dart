import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_people/people/domain/use_cases/popular_people_use_case.dart';
import 'package:movies_people/utils/async.dart';
import 'package:movies_people/utils/common.dart';
import 'popular_people_state.dart';

class PopularPeopleCubit extends Cubit<PopularPeopleState> {
  final PopularPeopleUseCase _popularPeopleUseCase;

  PopularPeopleCubit(this._popularPeopleUseCase) : super(const PopularPeopleState.initial());

  void paginate(int page) async {
    emit(state.reduce(popularPeople: const Async.loading()));

    try {
      final result = await _popularPeopleUseCase.execute(page);
      emit(state.reduce(popularPeople: Async.success(result)));
    } catch(e) {
      logDebug(e);
      emit(state.reduce(
        errorMessage: "Something went wrong",
        popularPeople: const Async.failure("error")
      ));
    }
  }
}