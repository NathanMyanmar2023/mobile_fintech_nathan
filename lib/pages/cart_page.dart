import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fnge/bloc/cart_bloc.dart';
import 'package:fnge/bloc/delete_cart_bloc.dart';
import 'package:fnge/bloc/update_cart_bloc.dart';
import 'package:fnge/extensions/navigation_extensions.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/cart_ob.dart';
import 'package:fnge/pages/check_out_page.dart';
import 'package:fnge/resources/colors.dart';
import 'package:fnge/resources/constants.dart';
import 'package:fnge/views/custom/snack_bar.dart';
import 'package:fnge/widgets/long_button_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../helpers/shared_pref.dart';
import '../widgets/nathan_text_view.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _cartBloc = CartBloc();
  late Stream<ResponseOb> _cartStream;
  CartData? cart;

  final _updateCartBloc = UpdateCartBloc();
  late Stream<ResponseOb> _updateCartStream;

  final _deleteCartBloc = DeleteCartBloc();
  late Stream<ResponseOb> _deleteCartStream;

  @override
  void initState() {
    super.initState();

    /// cart list stream
    _cartStream = _cartBloc.cartStream();
    _cartStream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          cart = (resp.data as CartOb).data;
          print("cc $cart");
        });
      } else {}
    });

    /// update cart stream
    _updateCartStream = _updateCartBloc.updateCartStream();
    _updateCartStream.listen((ResponseOb resp) {
      if (resp.success) {
        _cartBloc.cartList();
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Success'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(welcomeLogo, height: 100, width: 100),
                    const SizedBox(height: 10),
                    Text(
                      resp.message.toString(),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      popBack(context: context);
                      _cartBloc.cartList();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: colorPrimary,
                      ),
                    ),
                  ),
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error!'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(welcomeLogo, height: 100, width: 100),
                    const SizedBox(height: 10),
                    Text(
                      resp.message.toString(),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      popBack(context: context);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: colorPrimary,
                      ),
                    ),
                  ),
                ],
              );
            });
      }
    });

    /// delete cart stream
    _deleteCartStream = _deleteCartBloc.deleteCartStream();
    _deleteCartStream.listen((ResponseOb resp) {
      if (resp.success) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Success'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(welcomeLogo, height: 100, width: 100),
                    const SizedBox(height: 10),
                    Text(
                      resp.message.toString(),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      popBack(context: context);
                      _cartBloc.cartList();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: colorPrimary,
                      ),
                    ),
                  ),
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error!'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(welcomeLogo, height: 100, width: 100),
                    const SizedBox(height: 10),
                    Text(
                      resp.message.toString(),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      popBack(context: context);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: colorPrimary,
                      ),
                    ),
                  ),
                ],
              );
            });
      }
    });

    _cartBloc.cartList();
    saveInfo();
  }

  String? currency = "";
  // int? totalAmount = 0;
  List localItem = [];
  var totalAmount = 0;
  void saveInfo() async {
    currency = await SharedPref.getData(key: SharedPref.currency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: AppBar(
            toolbarHeight: 70,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: colorPrimary,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              "Cart Page",
              style: TextStyle(
                fontSize: 16,
                color: colorPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
      body: cart == null
          ? const Center(
              child: Text("No More Data"),
            )
          : cart!.items!.isEmpty
              ? const Center(
                  child: Text("No More Data"),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: cart?.items?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                                bottom: 8,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 120,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Image.network(
                                          cart?.items?[index].productImage ??
                                              "",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.52,
                                                  child: Text(
                                                    cart?.items?[index]
                                                            .productName ??
                                                        "-",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      _deleteCartBloc
                                                          .deleteShoppingCart(
                                                        id: cart?.items?[index]
                                                                .cartId ??
                                                            0,
                                                      );
                                                    },
                                                    child: const Icon(
                                                      Icons.delete_forever,
                                                      color: Colors.red,
                                                      size: 23,
                                                    )),
                                              ],
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              'Brand: ${cart?.items?[index].brandName ?? "-"}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Price: ${cart?.items?[index].totalSKUPrice ?? "-"}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            cart?.items?[index]
                                                        .productDiscount !=
                                                    null
                                                ? cart!.items![index]
                                                            .productDiscount! >
                                                        0
                                                    ? Text(
                                                        'Discount: ${cart?.items?[index].productDiscount ?? "-"}',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey
                                                              .withOpacity(0.8),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      )
                                                    : const SizedBox()
                                                : const SizedBox(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if ((cart?.items?[index]
                                                              .productQuality ??
                                                          1) <
                                                      cart!.items![index]
                                                          .onHandStock!) {
                                                    cart?.items?[index]
                                                        .productQuality = (cart
                                                                ?.items?[index]
                                                                .productQuality ??
                                                            1) +
                                                        1;
                                                  }
                                                  if (cart?.items?[index]
                                                          .productQuality ==
                                                      cart?.items?[index]
                                                          .onHandStock) {
                                                    context.showSnack(
                                                      "Out Of Stock!",
                                                      Colors.white,
                                                      Colors.red,
                                                      Icons.close,
                                                    );
                                                  }
                                                });
                                              },
                                              child: const Icon(
                                                Icons.keyboard_arrow_up,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Text(
                                              "${cart?.items?[index].productQuality ?? "1"}",
                                              style: const TextStyle(
                                                color: colorPrimary,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                print(
                                                    "first ${cart?.items?[index].productQuality}");
                                                setState(() {
                                                  if ((cart?.items?[index]
                                                              .productQuality ??
                                                          1) >
                                                      1) {
                                                    cart?.items?[index]
                                                        .productQuality = (cart
                                                                ?.items?[index]
                                                                .productQuality ??
                                                            1) -
                                                        1;
                                                    print(
                                                        "foe2 ${cart?.items?[index].productQuality}");
                                                    print(
                                                        "localItem-dd1 $totalAmount");
                                                    // totalAmount -= cart!.items![index].productPrice ?? 0;
                                                    // print("localItem-dd2 $totalAmount");
                                                  }
                                                });
                                              },
                                              child: const Icon(
                                                Icons.keyboard_arrow_down,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${cart!.items![index].productSubTotal} $currency",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          color: colorWhite,
                                          onPressed: () =>
                                              _updateCartBloc.updateCart(data: {
                                            "cart_id":
                                                cart?.items?[index].cartId,
                                            "quantity": cart
                                                ?.items?[index].productQuality,
                                            "_method": "put",
                                          }),
                                          icon: const Icon(
                                            Icons.arrow_circle_up,
                                            color: colorPrimary,
                                          ),
                                        ),
                                        // Row(
                                        //   children: [
                                        //     Container(
                                        //       decoration: BoxDecoration(
                                        //         color: colorPrimary,
                                        //         borderRadius: BorderRadius.circular(8),
                                        //       ),
                                        //       child: IconButton(
                                        //         color: colorWhite,
                                        //         onPressed: () => _updateCartBloc.updateCart(data: {
                                        //           "cart_id": cart?.items?[index].cartId,
                                        //           "quantity": cart?.items?[index].productQuality,
                                        //           "_method": "put",
                                        //         }),
                                        //         icon: const Icon(Icons.arrow_circle_up),
                                        //       ),
                                        //     ),
                                        //     const SizedBox(
                                        //       width: 12,
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    Container(
                      color: colorSeconary.withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                NathanTextView(
                                  text:
                                      AppLocalizations.of(context)!.total_item,
                                  color: colorBlack,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                                NathanTextView(
                                  text: "${cart?.items?.length}",
                                  color: colorBlack,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Divider(
                              height: 2,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                NathanTextView(
                                  text: AppLocalizations.of(context)!.sub_total,
                                  color: colorBlack,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                                NathanTextView(
                                  text: money_format("${cart?.subTotal}"),
                                  color: colorBlack,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: LongButtonView(
                                text: AppLocalizations.of(context)!.check_out,
                                onTap: () => Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => const CheckOutPage(),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  String money_format(String amount) {
    double amountDouble = double.parse(amount);
    String formattedAmount = NumberFormat.currency(
      locale: 'en_US',
      decimalDigits: 2,
      symbol: '',
    ).format(amountDouble);
    return formattedAmount.toString();
  }
}
