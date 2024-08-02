import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fnge/views/screens/ecommerce/product_detail_screen.dart';

class ProductSelectorWidget extends StatefulWidget {
  final int id;
  final String name;
  final String description;
  final String detail;
  final String product_code;
  final int stock;
  final String price;
  final int discount;
  final String discount_price;
  final String photo;
  final int category_id;
  final String category_name;
  final String brand_name;
  final int brand_id;
  final int is_favourite;

  const ProductSelectorWidget({
    super.key,
    required this.id,
    required this.name,
    required this.description,
    required this.detail,
    required this.product_code,
    required this.stock,
    required this.price,
    required this.discount,
    required this.discount_price,
    required this.photo,
    required this.category_id,
    required this.category_name,
    required this.brand_name,
    required this.brand_id,
    required this.is_favourite,
  });

  @override
  State<ProductSelectorWidget> createState() => _ProductSelectorWidgetState();
}

class _ProductSelectorWidgetState extends State<ProductSelectorWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        elevation: 0,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ProductDetailScreen(
              id: widget.id,
              name: widget.name,
              description: widget.description,
              detail: widget.detail,
              product_code: widget.product_code,
              stock: widget.stock,
              price: widget.price,
              discount: widget.discount,
              discount_price: widget.discount_price,
              photo: widget.photo,
              category_id: widget.category_id,
              category_name: widget.category_name,
              brand_name: widget.brand_name,
              brand_id: widget.brand_id,
              is_favourite: widget.is_favourite,
            );
          }));
        },
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1 / 1,
                child: SizedBox(
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: widget.photo,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      widget.name.length > 40
                          ? "${widget.name.substring(0, 40)}..."
                          : widget.name,
                      maxLines: 2,
                      // widget.radios.
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.price,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.category_name,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
