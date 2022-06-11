import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_people/people/domain/use_cases/person_details_use_case.dart';
import 'package:movies_people/utils/async.dart';
import 'person_details_state.dart';

class PersonDetailsCubit extends Cubit<PersonDetailsState> {
  final PersonDetailsUseCase _personDetailsUseCase;

  PersonDetailsCubit(this._personDetailsUseCase) : super(const PersonDetailsState.initial());

  int personId = -1;

  void onStarted(int personId) async {
    this.personId = personId;
    await _loadData();
  }

  void retry() async {
    if (personId == -1) return;
    await _loadData();
  }

  Future<void> _loadData() async {
    emit(state.reduce(personDetails: const Async.loading()));

    try {
      final data = await _personDetailsUseCase.execute(personId);
      emit(state.reduce(personDetails: Async.success(data)));
    } catch (e) {
      emit(state.reduce(
        errorMessage: "Something went wrong",
        personDetails: const Async.failure("error"),
      ));
    }
  }
}