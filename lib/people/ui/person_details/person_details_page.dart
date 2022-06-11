import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_people/people/di/di_container.dart';
import 'person_details_cubit.dart';

class PersonDetailsPage extends StatelessWidget {
  static const String route = '/person_details';

  const PersonDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PersonDetailsCubit>(
      create: (context) {
        return PersonDetailsCubit(
          DiContainer.getPersonDetailsUseCase()
        );
      },
      child: Scaffold(
        body: PersonDetailsBody(),
      ),
    );
  }

}

class PersonDetailsBody extends StatelessWidget {
  const PersonDetailsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO Build your UI
    throw UnimplementedError();
  }
}