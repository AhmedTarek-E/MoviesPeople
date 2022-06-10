import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movies_people/utils/app_colors.dart';
import 'package:movies_people/utils/text_styles.dart';
import 'package:intl/intl.dart';

import 'dimensions.dart';

void logDebug(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}

Future<T?> pushMaterialPage<T>(
    BuildContext context,
    Widget page,
    {
      bool rootNavigator = false,
      RouteSettings? settings,
      bool fullscreenDialog = false
    }) {
  return Navigator.of(context, rootNavigator: rootNavigator)
      .push(MaterialPageRoute(
      builder: (context) => page,
      settings: settings,
      fullscreenDialog: fullscreenDialog
  ));
}

bool isRTL(String text) {
  return Bidi.detectRtlDirectionality(text);
}

void showErrorSnackBar(BuildContext context, String errorMessage, {
  Duration duration = const Duration(seconds: 3)
}) {
  logDebug(errorMessage);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    action: SnackBarAction(
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
      label: "إخفاء",
      textColor: AppColors.textSecondaryColor,
    ),
    duration: duration,
    backgroundColor: Colors.red,
    content: Row(
      children: [
        Expanded(
          child: Text(
            errorMessage,
            style: TextStyles.medium(
                color: Colors.white,
                fontSize: Dimensions.normal
            ),
            textAlign: isRTL(errorMessage) ? TextAlign.start : TextAlign.end,
          ),
        ),
      ],
    ),
  ));
}