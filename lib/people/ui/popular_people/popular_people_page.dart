import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'popular_people_cubit.dart';

class PopularPeoplePage extends StatelessWidget {
  static const String route = '/popular_people';

  const PopularPeoplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PopularPeopleCubit>(
      create: (context) {
        return PopularPeopleCubit();
      },
      child: Scaffold(
        body: PopularPeopleBody(),
      ),
    );
  }

}

class PopularPeopleBody extends StatelessWidget {
  const PopularPeopleBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO Build your UI
    throw UnimplementedError();
  }
}