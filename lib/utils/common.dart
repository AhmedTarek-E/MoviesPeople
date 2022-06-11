import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movies_people/utils/app_colors.dart';
import 'package:movies_people/utils/text_styles.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_android/path_provider_android.dart';
import 'package:path_provider_ios/path_provider_ios.dart';

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
      label: "Hide",
      textColor: AppColors.textTertiaryColor,
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

void showSuccessSnackBar(BuildContext context, String message,
    {VoidCallback? onDismissed}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 3),
    backgroundColor: AppColors.successLight,
    content: Row(
      children: [
        Expanded(
          child: Text(
            message,
            style: TextStyles.regular(
              color: AppColors.success,
              fontSize: Dimensions.normal,
            ),
          ),
        ),
      ],
    ),
  ));

  if (onDismissed != null) {
    Timer(const Duration(seconds: 3), () {
      onDismissed();
    });
  }
}

Future<void> saveImageLocally(String url) async {
  if (Platform.isAndroid) PathProviderAndroid.registerWith();
  if (Platform.isIOS) PathProviderIOS.registerWith();

  final response = await http.get(Uri.parse(url));
  final Directory? directory;
  if (Platform.isAndroid) {
    directory = await getApplicationDocumentsDirectory();
  } else {
    directory = await getApplicationDocumentsDirectory();
  }

  if (directory == null) return;

  try {
    final imagesPath = "${directory.path}/images";
    await Directory(imagesPath).create(recursive: true);

    final fileName = DateTime.now().millisecondsSinceEpoch.toString() + ".jpg";

    final file = File("$imagesPath/$fileName");
    await file.writeAsBytes(response.bodyBytes);
  } catch(e) {
    logDebug(e);
  }

}
