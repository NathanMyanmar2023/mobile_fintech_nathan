import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fnge/models/response_objects/cart/cart_response_object.dart';
import 'package:fnge/models/utils/app_utils.dart';
import 'package:fnge/views/widgets/ecommerce/cart_item_image_error_widget.dart';
import 'package:fnge/views/widgets/ecommerce/cart_item_image_loading_widget.dart';

class CartItemWidget extends StatefulWidget {
  final CartItems cartItems;
  final VoidCallback onTap;

  const CartItemWidget({
    super.key,
    required this.cartItems,
    required this.onTap,
  });

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  void changeQuantity(int changeAmount) {
    // setState(() {
    //   quantity = quantity + changeAmount;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: widget.onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.cartItems.productImage,
                  placeholder: (context, url) =>
                      const CartItemImageLoadingWidget(),
                  errorWidget: (context, url, error) =>
                      const CartItemImageErrorWidget(),
                  imageBuilder: (context, imageProvider) => Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 5),
                          blurRadius: 5,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.cartItems.productName,
                              maxLines: 2,
                              softWrap: true,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  "${AppUtils().formatAsMoney(widget.cartItems.productPrice.toString())} Ks",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "-${widget.cartItems.productDiscount}%",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  AppUtils().formatAsMoney(widget
                                      .cartItems.discountPrice
                                      .toString()),
                                  style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  "Ks",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              color: Colors.grey.shade200,
                              child: InkWell(
                                onTap: () {
                                  //decrease quantity
                                  if (widget.cartItems.productQuality > 1) {
                                    changeQuantity(-1);
                                  }
                                },
                                child: const Center(
                                  child: Icon(
                                    Icons.remove,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                              child: Center(
                                child: Text(
                                    widget.cartItems.productQuality.toString()),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              color: Colors.grey.shade200,
                              child: InkWell(
                                onTap: () {
                                  //increase quantity
                                  changeQuantity(1);
                                },
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text(
                              "Sub Total : ",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              AppUtils().formatAsMoney(
                                  widget.cartItems.productSubTotal.toString()),
                              style: const TextStyle(
                                color: Colors.pink,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              "Ks",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: Colors.grey.shade300,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}
