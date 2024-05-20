import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../pages/product_detail_page.dart';
import '../../../widgets/network_image_component.dart';

class ProductCardComponent extends StatelessWidget {
  final int id;
  final int stock;
final String photo;
final String name;
final String brandName;
  const ProductCardComponent({
    required this.id,
    required this.stock,
    required this.photo,
    required this.name,
    required this.brandName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => ProductDetailPage(
              productId: id,
            ),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.only(right: 3.w, bottom: 3.h),
        color: colorPrimary,
        elevation: 5,
        shadowColor: colorSeconary.withOpacity(0.3),
        child: SizedBox(
          height: MediaQuery.of(context).devicePixelRatio < 2.7 ? 30.h : 30.h,
          width: 42.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      height: double.infinity,
                      child: NetworkImageComponent(
                        url: photo,
                        indicatorSize: 20.sp,
                        errorIconSize: 20.sp,
                        boxFit: BoxFit.cover,
                      ),
                    ),
                    stock != 0 ? const SizedBox() :
                    Positioned(
                      top: 0,
                      right: 0,
                      bottom: 0,
                      left: 0,
                      child: Container(
                          color: Colors.black.withOpacity(0.5),
                          child: Center(
                            child: Text("Out of Stock", style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.w600, fontSize: 16.sp)),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 1.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "Brand: $brandName",
                        style: const TextStyle(
                          fontFamily: "Bold",
                          color: colorSeconary,
                          height: 1.2,
                        ),
                        textScaleFactor: 0.80,
                        maxLines: 1,
                      ),
                      SizedBox(height: 1.h),
                      AutoSizeText(
                        name,
                        style: const TextStyle(
                          fontFamily: "Bold",
                          color: colorWhite,
                          height: 1.2,
                        ),
                        maxFontSize: 15.0,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 1.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
