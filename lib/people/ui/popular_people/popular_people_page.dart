import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_people/utils/common.dart';
import 'package:movies_people/utils/retry_failed_loading.dart';
import 'popular_people_cubit.dart';
import 'popular_people_state.dart';

class PopularPeoplePage extends StatelessWidget {
  static const String route = '/popular_people';

  const PopularPeoplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PopularPeopleCubit>(
      create: (context) {
        return PopularPeopleCubit();
      },
      child: const Scaffold(
        body: PopularPeopleBody(),
      ),
    );
  }

}

class PopularPeopleBody extends StatelessWidget {
  const PopularPeopleBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PopularPeopleCubit, PopularPeopleState>(
      listener: (context, state) {
        if (state.errorMessage?.isNotEmpty ?? false) {
          showErrorSnackBar(context, state.errorMessage ?? "");
        }
      },
      child: Stack(
        children: [
          //View

          //Loading Widget
          Center(
            child: BlocBuilder<PopularPeopleCubit, PopularPeopleState>(
              builder: (context, state) {
                if (state.popularPeople.isLoading) {
                  return const CircularProgressIndicator.adaptive();
                }

                if (state.popularPeople.isFailure) {
                  return RetryFailedLoading(
                    onRetryPressed: () {
                      //TODO
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),


        ],
      ),
    );
  }
}