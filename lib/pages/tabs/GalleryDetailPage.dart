import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../admob_service.dart';

List<String> imageDirectories = [];

class GalleryDetailPage extends StatefulWidget {
  final List<String> imagePaths;
  final int currentIndex;

  const GalleryDetailPage(
      {Key? key, required this.imagePaths, required this.currentIndex})
      : super(key: key);

  @override
  _GalleryDetailPageState createState() => _GalleryDetailPageState();
}

class _GalleryDetailPageState extends State<GalleryDetailPage> {
  late PageController _pageController;
  late int currentIndex;

  late String newImagePath;

  void addImage() {
    setState(() {
      imageDirectories.add(newImagePath);
    });
  }

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
    _pageController = PageController(initialPage: currentIndex);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        width: 320,
        height: 100,
        color: Colors.deepPurple[800],
        child: AdWidget(
          key: UniqueKey(),
          ad: AdmobService.createSecondBannerAd()..load(),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[800],
      ),
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AdmobService.showRewardedAd();
          addImage();
        },
        backgroundColor: Colors.deepPurple[800],
        tooltip: 'Add this Image to library page',
        child: Center(
          child: Text(
            'Add to Library',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Stack(
      children: [
        buildPhotoViewGallery(),
      ],
    );
  }

  PhotoViewGallery buildPhotoViewGallery() {
    return PhotoViewGallery.builder(
      itemCount: widget.imagePaths.length,
      builder: (context, int index) {
        String imageDirectory = widget.imagePaths[index].toString();
        newImagePath = imageDirectory;

        return PhotoViewGalleryPageOptions(
          imageProvider: AssetImage(widget.imagePaths[index]),
          minScale: PhotoViewComputedScale.contained * 0.1,
          maxScale: PhotoViewComputedScale.covered * 1,
        );
      },
      scrollPhysics: BouncingScrollPhysics(),
      pageController: _pageController,
      onPageChanged: (int index) {
        setState(
          () {
            currentIndex = index;
          },
        );
      },
    );
  }
}
