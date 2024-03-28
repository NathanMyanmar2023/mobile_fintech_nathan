import 'package:flutter/material.dart';
import 'package:nathan_app/bloc/product_detail_bloc.dart';
import 'package:nathan_app/extensions/navigation_extensions.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/product_detail_ob.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/add_to_cart_bloc.dart';
import '../resources/colors.dart';
import '../widgets/long_button_view.dart';
import 'cart_page.dart';

class ProductDetailPage extends StatefulWidget {
  final int? productId;

  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final _productDetailBloc = ProductDetailBloc();
  late Stream<ResponseOb> productDetailStream;
  ProductData? productDetail;

  final _addToCartBloc = AddToCartBloc();
  late Stream<ResponseOb> _addToCartStream;

  @override
  void initState() {
    productDetailStream = _productDetailBloc.productDetailStream();
    print("dd ${widget.productId}");
    productDetailStream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          productDetail = (resp.data as ProductDetailOb).data;
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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const CartPage(),
                      ));
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

    _productDetailBloc.getProductDetail(productId: widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.product_detail,),
      ),
      body: productDetail == null ?
      const Padding(
        padding:  EdgeInsets.only(top: 50),
        child:  Center(
          child: CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              productDetail?.photo ?? "",
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productDetail?.name ?? "-",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      LongButtonView(
                        text: AppLocalizations.of(context)!.add_to_cart,
                        width: 100,
                        onTap: () =>
                            _addToCartBloc.addToCartList(
                                data: {
                                  "product_id": productDetail!.id,
                                  "quantity": 1,
                                }
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${AppLocalizations.of(context)!.brand}: ${productDetail?.brandName ?? "-"}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${AppLocalizations.of(context)!.price}: '
                        '${productDetail!.discount! > 0 ? productDetail!.discountPrice ?? 0 : productDetail!.price}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  productDetail!.discount > 0 ? Text(
                    'Discount: '
                        '${productDetail!.discount}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ) : const SizedBox(),
                  const SizedBox(height: 16),
                   Text(
                     AppLocalizations.of(context)!.product_detail,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    productDetail?.detail ?? "-",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                   Text(
                     AppLocalizations.of(context)!.photos,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Display additional photos
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: const EdgeInsets.only(right: 8),
                      child: Row(
                        children: List.generate(
                          productDetail?.photos?.length ?? 0,
                          (index) => Container(
                            margin: const EdgeInsets.only(
                              left: 8,
                            ),
                            child: Image.network(
                              productDetail?.photos?[index] ?? "",
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
