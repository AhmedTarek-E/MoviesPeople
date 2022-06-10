import 'package:flutter/material.dart';
import 'package:movies_people/utils/app_colors.dart';
import 'package:movies_people/utils/dimensions.dart';
import 'package:movies_people/utils/text_styles.dart';

class AppNetworkImage extends StatelessWidget {
  final String image;
  final Color placeholderColor;
  final BoxFit fit;
  final double? height;
  final double? width;

  const AppNetworkImage({
    Key? key,
    required this.image,
    this.placeholderColor = AppColors.primaryLightColor,
    this.fit = BoxFit.cover, this.height, this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      width: width,
      height: height,
      placeholder: "",
      image: image,
      placeholderErrorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: placeholderColor,
        );
      },
      placeholderFit: BoxFit.cover,
      imageErrorBuilder: (context, error, stackTrace) {
        return Center(
          child: Text(
            "لا يوجد صورة",
            textAlign: TextAlign.center,
            style: TextStyles.regular(
                color: AppColors.textPrimaryColor,
                fontSize: Dimensions.normal
            ),
          ),
        );
      },
      fit: fit,
    );
  }
}
