import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies_people/people/di/di_container.dart';
import 'package:movies_people/people/domain/models/pagination_data.dart';
import 'package:movies_people/people/domain/models/person_info.dart';
import 'package:movies_people/people/ui/popular_people/widgets/person_item_view.dart';
import 'package:movies_people/utils/app_colors.dart';
import 'package:movies_people/utils/application_app_bars.dart';
import 'package:movies_people/utils/common.dart';
import 'package:movies_people/utils/dimensions.dart';
import 'package:movies_people/utils/retry_failed_loading.dart';
import 'package:movies_people/utils/text_styles.dart';
import 'popular_people_cubit.dart';
import 'popular_people_state.dart';

class PopularPeoplePage extends StatelessWidget {
  static const String route = '/popular_people';

  const PopularPeoplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PopularPeopleCubit>(
      create: (context) {
        return PopularPeopleCubit(
          DiContainer.getPopularPeopleUseCase()
        );
      },
      child: Scaffold(
        appBar: ApplicationAppBars.normalAppBar(
          title: "Popular People",
        ),
        body: const PopularPeopleBody(),
      ),
    );
  }

}

class PopularPeopleBody extends StatefulWidget {
  const PopularPeopleBody({Key? key}) : super(key: key);

  @override
  State<PopularPeopleBody> createState() => _PopularPeopleBodyState();
}

class _PopularPeopleBodyState extends State<PopularPeopleBody> {
  final _pagingController = PagingController<int, PersonInfo>(
      firstPageKey: 1, invisibleItemsThreshold: 8);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      BlocProvider.of<PopularPeopleCubit>(context).paginate(pageKey);
    });
    super.initState();
  }

  void _onDataLoaded(PaginationData<PersonInfo> result) {
    if (_pagingController.nextPageKey != result.pageInfo.page) return;

    if (result.pageInfo.hasNext) {
      _pagingController.appendPage(result.data, result.pageInfo.page + 1);
    } else {
      _pagingController.appendLastPage(result.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PopularPeopleCubit, PopularPeopleState>(
      listener: (context, state) {
        if (state.errorMessage?.isNotEmpty ?? false) {
          showErrorSnackBar(context, state.errorMessage ?? "");
        }

        if (state.popularPeople.isFailure) {
          _pagingController.error = "error";
        }

        if (state.popularPeople.isSuccessWithData) {
          _onDataLoaded(state.popularPeople.data!);
        }
      },
      child: Stack(
        children: [
          //View
          _buildPeopleList(),

          //Loading Widget
          Center(
            child: BlocBuilder<PopularPeopleCubit, PopularPeopleState>(
              builder: (context, state) {
                if (state.popularPeople.isFailure) {
                  return RetryFailedLoading(
                    onRetryPressed: () {
                      _pagingController.refresh();
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

  Widget _buildPeopleList() {
    return PagedListView<int, PersonInfo>.separated(
      padding: EdgeInsets.symmetric(
        vertical: PaddingDimensions.large,
        horizontal: PaddingDimensions.large,
      ),
      pagingController: _pagingController,
      separatorBuilder: (context, index) => const SizedBox(height: 8,),
      builderDelegate: PagedChildBuilderDelegate(
        firstPageErrorIndicatorBuilder: (context) {
          return Container();
        },
        firstPageProgressIndicatorBuilder: (context) {
          return const Center(child: CircularProgressIndicator.adaptive());
        },
        newPageProgressIndicatorBuilder: (context) {
          return const Center(child: CircularProgressIndicator.adaptive());
        },
        noItemsFoundIndicatorBuilder: (context) {
          return Center(
            child: Text(
              "Couldn't find popular people",
              style: TextStyles.semiBold(
                  color: AppColors.textPrimaryColor,
                  fontSize: Dimensions.normal
              ),
            ),
          );
        },
        itemBuilder: (context, item, index) {
          return PersonItemView(
            person: item,
            onPressed: _onPersonPressed,
          );
        },
      ),
    );
  }

  void _onPersonPressed(PersonInfo person) {
    //TODO: navigate to details
  }
}
