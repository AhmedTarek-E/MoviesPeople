import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_people/utils/app_colors.dart';
import 'package:movies_people/utils/dimensions.dart';
import 'package:movies_people/utils/text_styles.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewPage extends StatefulWidget {
  final ImageProvider imageProvider;

  const ImagePreviewPage({Key? key, required this.imageProvider}) : super(key: key);

  factory ImagePreviewPage.file(String path) {
    return ImagePreviewPage(
        imageProvider: FileImage(File.fromUri(Uri.file(path)))
    );
  }

  factory ImagePreviewPage.network(String url) {
    return ImagePreviewPage(
        imageProvider: NetworkImage(url)
    );
  }

  @override
  _ImagePreviewPageState createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.clear_thick_circled,
            color: Colors.white,
          ),
          onPressed: () {
            _onBackPressed(context);
          },
        ),
        toolbarHeight: Dimensions.toolbarHeight,
        title: Text(
          "عرض الصورة",
          style: TextStyles.semiBold(
              color: AppColors.textSecondaryColor,
              fontSize: Dimensions.xLarge
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: PhotoView(
        imageProvider: widget.imageProvider,
      ),
    );
  }

  void _onBackPressed(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
