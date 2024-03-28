import 'package:flutter/material.dart';

class CartItemImageLoadingWidget extends StatelessWidget {
  const CartItemImageLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade200,
      ),
    );
  }
}
