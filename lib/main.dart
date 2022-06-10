import 'package:flutter/material.dart';

import 'utils/app_colors.dart';
import 'utils/dimensions_initializer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies People',
      debugShowCheckedModeBanner: false,
      color: AppColors.appBackgroundColor,
      theme: ThemeData(
          primaryColor: AppColors.primaryColor
      ),
      locale: const Locale("ar"),
      supportedLocales: const [Locale("ar"), Locale("en")],
      //TODO
      home: const DimensionsInitializer(child: SizedBox()),
    );
  }
}