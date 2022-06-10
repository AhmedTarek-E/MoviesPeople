import 'package:flutter/material.dart';
import 'package:movies_people/utils/text_styles.dart';

import 'app_colors.dart';
import 'dimensions.dart';

class RetryFailedLoading extends StatelessWidget {
  final String message;
  final String retryButtonTitle;
  final VoidCallback onRetryPressed;
  final bool isRetryLoading;

   RetryFailedLoading({
    Key? key,
    String? message,
    String? retryButtonTitle,
    required this.onRetryPressed,
    this.isRetryLoading = false,
  })  : message = message ?? "فشل التحميل",
        retryButtonTitle = retryButtonTitle ?? "إعادة المحاولة",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Text(
          message,
          style: TextStyles.semiBold(
              color: AppColors.textPrimaryColor,
              fontSize: Dimensions.large
          ),
        ),

        const SizedBox(height: 16,),
        TextButton(
          onPressed: onRetryPressed,
          child: Text(
            retryButtonTitle,
            style: TextStyles.semiBold(
                color: AppColors.textSecondaryColor,
                fontSize: Dimensions.large),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => AppColors.primaryColor),
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            )),
          ),
        ),
      ],
    );
  }
}
