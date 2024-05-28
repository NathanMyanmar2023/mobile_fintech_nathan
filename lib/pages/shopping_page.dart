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
import 'package:responsive_sizer/responsive_sizer.dart';

import '../views/screens/history/phone_bill_history/phone_bill_history_selector_widget.dart';

class ShoppingPage extends StatefulWidget {
  final int? brandId;
  final int? categoryId;
  const ShoppingPage({super.key, required this.brandId, required this.categoryId});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  final _shoppingBloc = ShoppingBloc();
  late Stream<ResponseOb> _shoppingStream;
  List<ShoppingData> allshoppingProductList = [];
 List shoppingProductList = [];
  final _addToCartBloc = AddToCartBloc();
  late Stream<ResponseOb> _addToCartStream;

  bool isLoading = false;
  bool isFetching = false;
  final scroll_controller = ScrollController();

  int page = 1;
  int limit = 30;
  bool hasMore = true;
  Future fetch() async {
    widget.brandId == 0 ? _shoppingBloc.getCategoryProducts(categoryId: widget.categoryId, page: page) :
    _shoppingBloc.getShoppingProduct(brandId: widget.brandId, page: page);
    print(hasMore);
    if (isFetching) return;
    isFetching = true;
    if (hasMore == true) {
      print("truh as");
      widget.brandId == 0 ? _shoppingBloc.getCategoryProducts(categoryId: widget.categoryId, page: page) :
      _shoppingBloc.getShoppingProduct(brandId: widget.brandId, page: page);
      print("getting page - $page");
    }
  }

  Future refersh() async {
    setState(() {
      isFetching = false;
      hasMore = true;
      page = 1;
      shoppingProductList.clear();
    });

    fetch();
  }
  @override
  void initState() {
    super.initState();

    /// shopping stream
    _shoppingStream = _shoppingBloc.shoppingStream();
    _shoppingStream.listen((ResponseOb resp) {
      print("rese ${resp.loadPostState}");
      if (resp.success) {
        setState(() {

print("resp.data.data.length ${resp.data.data.length}");
          for (var i = 0; i < resp.data.data.length; i++) {
            shoppingProductList.add([
              resp.data.data[i].id,//0
              resp.data.data[i].name.toString(),//1
              resp.data.data[i].stock,//2
              resp.data.data[i].price.toString(),//3
              resp.data.data[i].discount,//4
              resp.data.data[i].discountPrice.toString(),//5
              resp.data.data[i].photo.toString(),//6
              resp.data.data[i].categoryId,//7
              resp.data.data[i].categoryName.toString(),//8
              resp.data.data[i].brandName.toString(),//9
              resp.data.data[i].brandId,//10
              resp.data.data[i].isFavourite,//11
              resp.data.data[i].description.toString(),//12
              resp.data.data[i].detail.toString(),//13
              resp.data.data[i].count,//14
            ]);
          }
          isLoading = false;
          page++;

          isFetching = false;
            if (resp.data.data.length == 10) {
              print("odoeor");
              hasMore = false;
              fetch();
            }
        });
      } else {
        isLoading = false;}
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

    widget.brandId == 0 ? _shoppingBloc.getCategoryProducts(categoryId: widget.categoryId, page: page) :
    _shoppingBloc.getShoppingProduct(brandId: widget.brandId, page: page);

    //Scroll controller
    scroll_controller.addListener(() {
      if (scroll_controller.position.maxScrollExtent ==
          scroll_controller.offset) {
        fetch();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            shoppingProductList.isEmpty ?
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: Text(
                      AppLocalizations.of(context)!.no_more_data,),
              ),
            ): SizedBox(
             // height: MediaQuery.of(context).size.height - 120,
              child: RefreshIndicator(
                onRefresh: refersh,
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  itemCount: shoppingProductList.length,
                  controller: scroll_controller,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final productList = shoppingProductList[index];
                    if (index < shoppingProductList.length) {
                      return
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => ProductDetailPage(
                                productId: productList[0],
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
                                    Stack(
                                      children: [
                                        Container(
                                          height: 120,
                                          width: 120,
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Image.network(
                                            productList[6] ??
                                                "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        productList[2] != 0 ? const SizedBox() : Positioned(
                                          top: 0,
                                          right: 0,
                                          bottom: 0,
                                          left: 0,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.5),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Center(
                                                child: Text("Out of Stock", style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.w600, fontSize: 16.sp)),
                                              )
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              productList[1] ?? "-",
                                              maxLines: 3,
                                              softWrap: true,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              '${AppLocalizations.of(context)!.brand}: ${productList[9] ?? "-"}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              '${AppLocalizations.of(context)!.price}: '
                                                  '${productList[3]! == "0" ? productList[3] ?? "0" : productList[3]}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            productList[4] != 0 ? Text(
                                              'Discount: '
                                                  '${productList[4]}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ) : const SizedBox(),
                                          ],
                                        ),
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
                                                if ((productList[14] ??
                                                    1) < productList[2]) {
                                                  productList[14] =
                                                      (productList[14] ??
                                                          1) +
                                                          1;
                                                }
                                                if(productList[14] == productList[2]) {
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
                                            "${productList[14] ?? "1"}",
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
                                                if ((productList[14] ??
                                                    1) >
                                                    1) {
                                                  productList[14] =
                                                      (productList[14] ??
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
                                                productList[1] ?? 0,
                                                "quantity":
                                                productList[14] ?? 1,
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
                        );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Center(
                          child: hasMore
                              ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ))
                              : Text(
                            AppLocalizations.of(context)!.no_more_data,
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    }
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
