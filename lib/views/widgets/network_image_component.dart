import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fnge/resources/colors.dart';

class NetworkImageComponent extends StatelessWidget {
  final String url;
  final Color? backgroundColor;
  final double indicatorSize;
  final double errorIconSize;
  final BoxFit boxFit;

  const NetworkImageComponent({
    required this.url,
    this.backgroundColor,
    required this.indicatorSize,
    required this.errorIconSize,
    required this.boxFit,
    Key? key,
  }) : super(key: key);

  get lightSecondaryColor => null;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url.isEmpty ? "" : url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.grey.shade200,
          image: DecorationImage(
            image: imageProvider,
            fit: boxFit,
            colorFilter: const ColorFilter.mode(
              colorPrimary,
              BlendMode.softLight,
            ),
          ),
        ),
      ),
      placeholder: (context, url) => const SizedBox(
        child: Center(
            child: CircularProgressIndicator(
          backgroundColor: colorWhite,
        )),
        height: 30.0,
        width: 30.0,
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.image_outlined,
        size: errorIconSize,
      ),
    );
  }
}
