import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_people/utils/text_styles.dart';

import 'app_colors.dart';
import 'dimensions.dart';

class ApplicationAppBars {
  ApplicationAppBars._();

  static AppBar normalAppBar({
    required String title,
    BuildContext? context,
    VoidCallback? onBackPressed,
    Color tintColor = AppColors.textTertiaryColor,
    bool useCloseButton = false,
  }) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.primaryColor,
      shadowColor: Colors.transparent,
      leading: context != null ? IconButton(
        icon: Icon(
          useCloseButton
              ? CupertinoIcons.clear_thick_circled
              : CupertinoIcons.back,
          color: tintColor,
        ),
        onPressed: () {
          if (context != null) {
            _onBackPressed(context);
          }

          if (onBackPressed != null) {
            onBackPressed();
          }
        },
      ) : null,
      toolbarHeight: Dimensions.toolbarHeight,
      title: Text(
        title,
        style: TextStyles.semiBold(
            color: tintColor,
            fontSize: Dimensions.xLarge
        ),
      ),
    );
  }

  static void _onBackPressed(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}