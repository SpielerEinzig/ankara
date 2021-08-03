import 'dart:async';
import 'dart:convert';

import 'package:ankara_catalogue/pages/tabs/GalleryDetailPage.dart';
import 'package:ankara_catalogue/pages/tabs/galleryImageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Gallery extends StatelessWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: FutureBuilder(
        future: loadImagePaths(context),
        builder: (
          BuildContext context,
          AsyncSnapshot/*<List<String>>*/ imagePathsSnapShot,
        ) {
          if (imagePathsSnapShot.connectionState == ConnectionState.done &&
              imagePathsSnapShot.hasData) {
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(10),
                  sliver: buildContents(imagePathsSnapShot.data),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

SliverGrid buildContents(List<String> imagePaths) {
  return SliverGrid(
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 150,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
    ),
    delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return GalleryImageWidget(
        imagePath: imagePaths[index],
        onImageTap: () => Navigator.push(
          context,
          _createGalleryDetailRoute(imagePaths, index),
        ),
      );
    }, childCount: imagePaths.length),
  );
}

MaterialPageRoute _createGalleryDetailRoute(
    List<String> imagePaths, int index) {
  return MaterialPageRoute(
    builder: (context) => GalleryDetailPage(
      imagePaths: imagePaths,
      currentIndex: index,
    ),
  );
}

Future<List<String>> loadImagePaths(BuildContext context) async {
  final String manifestContentJson =
      await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
  final Map<String, dynamic> manifestMap = json.decode(manifestContentJson);

  return manifestMap.keys
      .where((String key) => key.contains('assets/images/'))
      .toList();
}
