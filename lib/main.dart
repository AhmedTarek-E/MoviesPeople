import 'package:flutter/material.dart';
import 'package:movies_people/people/ui/popular_people/popular_people_page.dart';

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
      theme: ThemeData(primaryColor: AppColors.primaryColor),
      home: const DimensionsInitializer(
        child: PopularPeoplePage(),
      ),
    );
  }
}