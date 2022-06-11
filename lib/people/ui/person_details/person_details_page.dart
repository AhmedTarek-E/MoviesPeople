import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:movies_people/people/di/di_container.dart';
import 'package:movies_people/people/domain/models/person_details.dart';
import 'package:movies_people/people/ui/person_details/person_details_state.dart';
import 'package:movies_people/people/ui/popular_people/popular_people_cubit.dart';
import 'package:movies_people/people/ui/popular_people/popular_people_state.dart';
import 'package:movies_people/utils/app_colors.dart';
import 'package:movies_people/utils/application_app_bars.dart';
import 'package:movies_people/utils/common.dart';
import 'package:movies_people/utils/dimensions.dart';
import 'package:movies_people/utils/image_preview/app_network_image.dart';
import 'package:movies_people/utils/image_preview/image_preview_page.dart';
import 'package:movies_people/utils/retry_failed_loading.dart';
import 'package:movies_people/utils/text_styles.dart';
import 'person_details_cubit.dart';

class PersonDetailsPage extends StatelessWidget {
  static const String route = '/person_details';

  final int personId;

  const PersonDetailsPage({Key? key, required this.personId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PersonDetailsCubit>(
      create: (context) {
        return PersonDetailsCubit(
          DiContainer.getPersonDetailsUseCase()
        )..onStarted(personId);
      },
      child: Scaffold(
        appBar: ApplicationAppBars.normalAppBar(
          title: "Person Details",
          context: context,
        ),
        backgroundColor: AppColors.backgroundColor,
        body: const PersonDetailsBody(),
      ),
    );
  }

}

class PersonDetailsBody extends StatelessWidget {
  const PersonDetailsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonDetailsCubit, PersonDetailsState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          showErrorSnackBar(context, state.errorMessage ?? "");
        }
      },
      child: Stack(
        children: [
          BlocBuilder<PersonDetailsCubit, PersonDetailsState>(
            builder: (context, state) {
              if (state.personDetails.isSuccessWithData) {
                return _buildDetails(state.personDetails.data!);
              }
              return const SizedBox();
            }
          ),

          Center(
            child: BlocBuilder<PersonDetailsCubit, PersonDetailsState>(
              builder: (context, state) {
                if (state.personDetails.isLoading) {
                  return const CircularProgressIndicator.adaptive();
                }
                if (state.personDetails.isFailure) {
                  return RetryFailedLoading(
                    onRetryPressed: () {
                      BlocProvider.of<PersonDetailsCubit>(context).retry();
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

  Widget _buildDetails(PersonDetails personDetails) {
    return ListView(
      padding: EdgeInsets.symmetric(
        vertical: PaddingDimensions.large,
        horizontal: PaddingDimensions.large
      ),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AppNetworkImage(
                    image: personDetails.info.profilePicture,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            SizedBox(width: PaddingDimensions.large,),

            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    personDetails.info.name,
                    style: TextStyles.bold(
                      color: AppColors.textPrimaryColor,
                      fontSize: Dimensions.xLarge,
                    ),
                  ),
                  
                  SizedBox(height: PaddingDimensions.large,),
                  
                  Text(
                    personDetails.formatBirthday(),
                    style: TextStyles.regular(
                      color: AppColors.textPrimaryColor,
                      fontSize: Dimensions.normal
                    ),
                  ),

                  SizedBox(height: PaddingDimensions.normal,),

                  Text(
                    personDetails.formatPlaceOfBirth(),
                    style: TextStyles.regular(
                      color: AppColors.textPrimaryColor,
                      fontSize: Dimensions.normal
                    ),
                  ),

                ],
              ),
            )
          ],
        ),

        SizedBox(height: PaddingDimensions.large,),

        Text(
          personDetails.biography,
          style: TextStyles.regular(
            color: AppColors.textPrimaryColor,
            fontSize: Dimensions.normal
          ),
        ),

        SizedBox(height: PaddingDimensions.large,),

        PersonDetailsImages(images: personDetails.images),
      ],
    );
  }
}

class PersonDetailsImages extends StatelessWidget {
  final List<String> images;

  const PersonDetailsImages({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3/4,
      crossAxisSpacing: PaddingDimensions.normal,
      mainAxisSpacing: PaddingDimensions.normal,
      children: images.map((e) {
        return InkWell(
          onTap: () {
            _onImagePressed(context, e);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AppNetworkImage(image: e),
          ),
        );
      }).toList(),
    );
  }

  void _onImagePressed(BuildContext context, String image) {
    final url = image.replaceAll("w185", "original");
    pushMaterialPage(
      context,
      ImagePreviewPage.network(
        url,
        onSavePressed: () {
          _saveImage(context, url);
        },
      ),
    );
  }

  void _saveImage(BuildContext context, String image) async {
    await GallerySaver.saveImage(
      image,
      albumName: "MoviesPeople",
    );
    showSuccessSnackBar(context, "Saved Image Successfully");
  }
}


extension on PersonDetails {
  String formatBirthday() {
    return "Birthday: $birthday";
  }

  String formatPlaceOfBirth() {
    return "Born in $placeOfBirth";
  }
}
