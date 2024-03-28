import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageSliderWidget extends StatelessWidget {
  final String photo;
  final String index;
  final String photoLength;

  const ImageSliderWidget({
    super.key,
    required this.photo,
    required this.index,
    required this.photoLength,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              print('HELLO');
            },
            child: Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade100,
              child: CachedNetworkImage(
                imageUrl: photo,
                // placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(
                  Icons.image_not_supported,
                  size: 60,
                  color: Colors.grey.shade300,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                color: const Color.fromARGB(100, 0, 0, 0),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  "$index/$photoLength",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
