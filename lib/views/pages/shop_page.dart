import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nathan_app/bloc/products/products_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/ecommerce/product_selector_widget.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  bool isLoading = true;
  bool isFetching = false;
  final scroll_controller = ScrollController();

  final _products_bloc = ProductsBloc();
  late Stream<ResponseOb> _products_stream;

  int page = 1;
  int limit = 10;
  bool hasMore = true;

  List products_list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _products_stream = _products_bloc.productsStream();
    _products_stream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          for (var i = 0; i < resp.data.data.length; i++) {
            products_list.add(
              {
                "id": resp.data.data[i].id,
                "name": resp.data.data[i].name.toString(),
                "description": resp.data.data[i].description.toString(),
                "detail": resp.data.data[i].detail.toString(),
                "product_code": resp.data.data[i].productCode.toString(),
                "stock": resp.data.data[i].stock,
                "price": resp.data.data[i].price,
                "discount": resp.data.data[i].discount,
                "discount_price": resp.data.data[i].discountPrice,
                "photo": resp.data.data[i].photo.toString(),
                "category_id": resp.data.data[i].categoryId,
                "category_name": resp.data.data[i].categoryName.toString(),
                "brand_name": resp.data.data[i].brandName.toString(),
                "brand_id": resp.data.data[i].brandId,
                "is_favourite": resp.data.data[i].isFavourite,
              },
            );
          }
          isLoading = false;
          page++;
          isFetching = false;
          if (resp.data.data.length < limit) {
            hasMore = false;
          }
        });

        // print(products_list[0]["id"]);
      } else {
        isLoading = false;
        print("ERROR");
      }
    });

    fetch();

    //Scroll controller
    scroll_controller.addListener(() {
      if (scroll_controller.position.maxScrollExtent ==
          scroll_controller.offset) {
        fetch();
      }
    });
  }

  Future fetch() async {
    print("Has More product : $hasMore");

    if (isFetching) return;
    isFetching = true;
    if (hasMore == true) {
      _products_bloc.getProducts(page);
      print("getting page - $page");
    }
  }

  Future refersh() async {
    setState(() {
      isFetching = false;
      hasMore = true;
      page = 1;
      products_list.clear();
      isLoading = true;
    });

    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            child: MasonryGridView.builder(
              itemCount: 6,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 250 * (Random().nextDouble() * (1 - 0.8) + 0.8),
                      color: const Color.fromARGB(20, 0, 0, 0),
                    ),
                  ),
                );
              },
            ),
          )
        : MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: Scaffold(
              backgroundColor: Colors.grey.shade200,
              body: RefreshIndicator(
                onRefresh: refersh,
                child: MasonryGridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: scroll_controller,
                  itemCount: products_list.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    if (index < products_list.length) {
                      final product = products_list[index];
                      return ProductSelectorWidget(
                        id: product["id"],
                        name: product["name"],
                        description: product["description"],
                        detail: product["detail"],
                        product_code: product["product_code"],
                        stock: product["stock"],
                        price: product["price"],
                        discount: product["discount"],
                        discount_price: product["discount_price"],
                        photo: product["photo"],
                        category_id: product["category_id"],
                        category_name: product["category_name"],
                        brand_name: product["brand_name"],
                        brand_id: product["brand_id"],
                        is_favourite: product["is_favourite"],
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
                  },
                ),
              ),
            ),
          );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
