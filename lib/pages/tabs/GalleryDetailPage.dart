import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

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

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
    _pageController = PageController(initialPage: currentIndex);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[800],
      ),
      body: _buildContent(),
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
        return PhotoViewGalleryPageOptions(
          imageProvider: AssetImage(widget.imagePaths[index]),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 1.5,
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
