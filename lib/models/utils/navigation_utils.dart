import 'package:flutter/material.dart';
import 'package:nathan_app/pages/cart_page.dart';
import 'package:nathan_app/pages/order_list_page.dart';
import 'package:nathan_app/views/screens/ecommerce/add_address_screen.dart';
import 'package:nathan_app/views/screens/ecommerce/cart_screen.dart';

void openCart(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const CartPage(),
    ),
  );
}

void openOrder(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const OrderListPage(),
    ),
  );
}

void openAddAddress(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AddAddressScreen(),
    ),
  );
}
