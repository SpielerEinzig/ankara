import 'package:flutter/material.dart';

class GalleryImageWidget extends StatelessWidget {
  final imagePath;
  final VoidCallback onImageTap;
  const GalleryImageWidget(
      {Key? key, required this.onImageTap, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(2, 2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: Colors.transparent,
          child: Ink.image(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            child: InkWell(
              onTap: onImageTap,
            ),
          ),
        ),
      ),
    );
  }
}
