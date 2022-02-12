import 'package:ankara_catalogue/pages/tabs/GalleryDetailPage.dart';
import 'package:ankara_catalogue/pages/tabs/galleryImageWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../admob_service.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: imageDirectories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GalleryImageWidget(
            onImageTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (
                context,
              ) =>
                      LibraryDetailPage(
                        currentIndex: index,
                        imageDirectoriesList: imageDirectories,
                      )),
            ),
            imagePath: imageDirectories[index],
          );
        },
      ),
    );
  }
}

class LibraryDetailPage extends StatefulWidget {
  final List<String> imageDirectoriesList;
  final int currentIndex;

  const LibraryDetailPage({
    Key? key,
    required this.currentIndex,
    required this.imageDirectoriesList,
  }) : super(key: key);

  void deleteItem(int selectedIndex) {
    imageDirectoriesList.removeAt(selectedIndex);
  }

  @override
  _LibraryDetailPageState createState() => _LibraryDetailPageState();
}

class _LibraryDetailPageState extends State<LibraryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          height: 100,
          width: 320,
          color: Colors.deepPurple[800],
          child: AdWidget(
            key: UniqueKey(),
            ad: AdmobService.createThirdBannerAd()..load(),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[800],
        ),
        body: _buildContent());
  }

  Widget _buildContent() {
    return buildPhotoViewGallery();
  }

  PhotoViewGallery buildPhotoViewGallery() {
    return PhotoViewGallery.builder(
      itemCount: widget.imageDirectoriesList.length,
      builder: (context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: AssetImage(widget.imageDirectoriesList[index]),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 1,
        );
      },
      scrollPhysics: BouncingScrollPhysics(),
    );
  }
}
