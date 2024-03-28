import 'package:flutter/material.dart';
import 'package:nathan_app/bloc/add_to_cart_bloc.dart';
import 'package:nathan_app/bloc/shopping_bloc.dart';
import 'package:nathan_app/extensions/navigation_extensions.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/shopping_ob.dart';
import 'package:nathan_app/pages/cart_page.dart';
import 'package:nathan_app/pages/order_list_page.dart';
import 'package:nathan_app/pages/product_detail_page.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nathan_app/views/custom/snack_bar.dart';

class ShoppingPage extends StatefulWidget {
  final int? brandId;
  const ShoppingPage({super.key, required this.brandId});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  final _shoppingBloc = ShoppingBloc();
  late Stream<ResponseOb> _shoppingStream;
  List<ShoppingData> shoppingProductList = [];

  final _addToCartBloc = AddToCartBloc();
  late Stream<ResponseOb> _addToCartStream;

  @override
  void initState() {
    super.initState();

    /// shopping stream
    _shoppingStream = _shoppingBloc.shoppingStream();
    _shoppingStream.listen((ResponseOb resp) {
      print("rese ${resp.loadPostState}");
      if (resp.success) {
        setState(() {
          shoppingProductList = (resp.data as ShoppingOb).data ?? [];
          print("shoppingProductList $shoppingProductList");
        });
      } else {}
    });

    /// add to cart stream
    _addToCartStream = _addToCartBloc.addToCartStream();
    _addToCartStream.listen((ResponseOb resp) {
      if (resp.success) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title:  Text(AppLocalizations.of(context)!.success,),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('images/welcome.png', height: 100, width: 100),
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
                    Image.asset('images/welcome.png', height: 100, width: 100),
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

    _shoppingBloc.getShoppingProduct(brandId: widget.brandId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            shoppingProductList.isEmpty ?
            Center(
              child: Text(
                    AppLocalizations.of(context)!.no_more_data,),
            ): ListView.builder(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              itemCount: shoppingProductList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) => shoppingProductList[index].stock == 0 ? const SizedBox() : InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => ProductDetailPage(
                      productId: shoppingProductList[index].id,
                    ),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    bottom: 16,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.network(
                              shoppingProductList[index].photo ??
                                  "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  shoppingProductList[index].name ?? "-",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${AppLocalizations.of(context)!.brand}: ${shoppingProductList[index].brandName ?? "-"}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${AppLocalizations.of(context)!.price}: '
                                      '${shoppingProductList[index].discount! > 0 ? shoppingProductList[index].discountPrice ?? 0 : shoppingProductList[index].price}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                shoppingProductList[index].discount! > 0 ? Text(
                                  'Discount: '
                                      '${shoppingProductList[index].discount}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ) : const SizedBox(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if ((shoppingProductList[index].count ??
                                          1) < shoppingProductList[index].stock!) {
                                        shoppingProductList[index].count =
                                            (shoppingProductList[index].count ??
                                                1) +
                                                1;
                                      }
                                      if(shoppingProductList[index].count == shoppingProductList[index].stock) {
                                        context.showSnack("Out Of Stock!",
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
                                  "${shoppingProductList[index].count ?? "1"}",
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
                                    setState(() {
                                      if ((shoppingProductList[index].count ??
                                              1) >
                                          1) {
                                        shoppingProductList[index].count =
                                            (shoppingProductList[index].count ??
                                                    1) -
                                                1;
                                      }
                                    });
                                  },
                                  child: const Icon(
                                    Icons.keyboard_arrow_down,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                  _addToCartBloc.addToCartList(
                                data: {
                                  "product_id":
                                  shoppingProductList[index].id ?? 0,
                                  "quantity":
                                  shoppingProductList[index].count ?? 1,
                                }
                              );
                          },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: colorPrimary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                      Icons.add_shopping_cart_outlined, size: 22, color: colorWhite,),

                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
