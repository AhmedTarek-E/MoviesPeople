import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_people/utils/app_colors.dart';
import 'package:movies_people/utils/dimensions.dart';
import 'package:movies_people/utils/text_styles.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewPage extends StatefulWidget {
  final ImageProvider imageProvider;
  final VoidCallback? onSavePressed;

  const ImagePreviewPage({
    Key? key,
    required this.imageProvider,
    this.onSavePressed,
  }) : super(key: key);

  factory ImagePreviewPage.file(String path) {
    return ImagePreviewPage(
        imageProvider: FileImage(File.fromUri(Uri.file(path)))
    );
  }

  factory ImagePreviewPage.network(String url, {VoidCallback? onSavePressed}) {
    return ImagePreviewPage(
      imageProvider: NetworkImage(url),
      onSavePressed: onSavePressed,
    );
  }

  @override
  _ImagePreviewPageState createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  void _onSavePressed() {
    if (widget.onSavePressed != null) {
      widget.onSavePressed!();
    }
  }

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
        centerTitle: true,
        title: Text(
          "عرض الصورة",
          style: TextStyles.semiBold(
              color: AppColors.textTertiaryColor,
              fontSize: Dimensions.xLarge
          ),
        ),
        actions: [
          Center(
            child: InkWell(
              onTap: _onSavePressed,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: PaddingDimensions.normal,
                  horizontal: PaddingDimensions.large,
                ),
                child: Text(
                  "Save",
                  style: TextStyles.bold(
                    color: AppColors.textTertiaryColor,
                    fontSize: Dimensions.normal
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: PaddingDimensions.large,),
        ],
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
