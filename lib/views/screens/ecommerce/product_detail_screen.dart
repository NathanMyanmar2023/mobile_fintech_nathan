import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nathan_app/view_models/product_view_model.dart';
import 'package:nathan_app/views/widgets/ecommerce/image_slider_widget.dart';
import 'package:provider/provider.dart';

import '../../../bloc/products/products_bloc.dart';
import '../../../helpers/response_ob.dart';

class ProductDetailScreen extends StatefulWidget {
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

  const ProductDetailScreen({
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
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isLoading = true;
  final _products_bloc = ProductsBloc();
  late Stream<ResponseOb> _products_stream;

  int quantity = 1;
  List photoList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _products_stream = _products_bloc.productsStream();
    _products_stream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          for (var i = 0; i < resp.data.data.length; i++) {
            photoList.add(
              {
                "name": resp.data.data[i].name.toString(),
                "index": (i + 1).toString(),
              },
            );
          }
          isLoading = false;
        });

        // print(products_list[0]["id"]);
      } else {
        isLoading = false;
        print("ERROR");
      }
    });

    _products_bloc.getPhotos(widget.id);
  }

  void changeQuantity(int changeAmount) {
    setState(() {
      quantity = quantity + changeAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    ProductViewModel productViewModel = context.watch<ProductViewModel>();
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            toolbarHeight: 70,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              widget.name,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      child: PageView(
                        children: photoList.map((photo) {
                          return ImageSliderWidget(
                            photo: photo["name"],
                            index: photo["index"],
                            photoLength: photoList.length.toString(),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ks.${widget.price}/-",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                            ),
                          ),
                          Text(widget.discount_price),
                          const SizedBox(height: 10),
                          Text(
                            textAlign: TextAlign.start,
                            widget.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
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
                          const SizedBox(height: 10),
                          Text(
                            widget.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            height: 2,
                            width: double.infinity,
                            color: Colors.grey.shade200,
                          ),
                          Text(
                            widget.detail,
                            style: TextStyle(
                              fontSize: 14,
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
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, -3),
                      blurRadius: 5,
                      color: Colors.black.withAlpha(20),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          color: Colors.grey.shade200,
                          child: InkWell(
                            onTap: () {
                              //decrease quantity
                              if (quantity > 1) {
                                changeQuantity(-1);
                              }
                            },
                            child: const Center(
                              child: Text(
                                "-",
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          child: Center(
                            child: Text("$quantity"),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          color: Colors.grey.shade200,
                          child: InkWell(
                            onTap: () {
                              //increase quantity
                              changeQuantity(1);
                            },
                            child: const Center(
                              child: Text(
                                "+",
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () async {
                        if (productViewModel.loading) {
                          return;
                        }

                        var response = await productViewModel.addToCart(
                            widget.id, quantity);
                        print(response);
                        if (response.success == true) {
                          Fluttertoast.showToast(
                            msg: response.message,
                            backgroundColor: Colors.green,
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: response.message,
                            backgroundColor: Colors.red,
                          );
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 150,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, -3),
                              blurRadius: 5,
                              color: Colors.black.withAlpha(20),
                            ),
                          ],
                        ),
                        child: Center(
                          child: productViewModel.loading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
