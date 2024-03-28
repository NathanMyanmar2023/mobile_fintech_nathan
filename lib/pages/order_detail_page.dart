import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nathan_app/bloc/product_detail_bloc.dart';
import 'package:nathan_app/extensions/navigation_extensions.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/product_detail_ob.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/add_to_cart_bloc.dart';
import '../bloc/order_detail_bloc.dart';
import '../helpers/response_data_ob.dart';
import '../helpers/shared_pref.dart';
import '../objects/order_detail_ob.dart';
import '../resources/colors.dart';
import '../widgets/long_button_view.dart';
import '../widgets/nathan_text_view.dart';
import '../widgets/order_info_view.dart';
import 'cart_page.dart';

class OrderDetailPage extends StatefulWidget {
  final String? orderId;

  const OrderDetailPage({
    super.key,
    required this.orderId,
  });

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final _orderDetailBloc = OrderDetailBloc();
  late Stream<ResponseOb> orderDetailStream;
  OrderDetailData? orderDetailData;

  @override
  void initState() {
    orderDetailStream = _orderDetailBloc.orderDetailStream();
    orderDetailStream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          orderDetailData = (resp.data as OrderDetailOb).data;
        });
      } else {}
    });

    _orderDetailBloc.getOrderDetail(orderId: widget.orderId);
    getSaveInfo();
    super.initState();
  }
String? currency;
  getSaveInfo() async {
    currency = await SharedPref.getData(key: SharedPref.currency);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Order Detail",),
      ),
      body:
      orderDetailData == null ?
      const Padding(
        padding:  EdgeInsets.only(top: 50),
        child:  Center(
          child: CircularProgressIndicator(),
        ),
      ) :
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const NathanTextView(
                        text: "Order Id - ",
                        color: colorBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),

                      NathanTextView(
                        text: "${orderDetailData?.items?.orderId}",
                        color: colorBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Expanded(
                  child: ListView.builder(
                    itemCount: orderDetailData?.items?.products?.length,
                    itemBuilder: (BuildContext context, int index) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  orderDetailData?.items?.products?[index].photo ?? "",
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          orderDetailData?.items?.products?[index].name ?? "-",
                                          style: const TextStyle(
                                            color: colorPrimary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            OrderInfoView(infoTitle: "Price", infoMsg: "${orderDetailData?.items?.products?[index].discountPrice}",),
                                            OrderInfoView(infoTitle: "Qty", infoMsg: "${orderDetailData?.items?.products?[index].quantity}",),
                                            OrderInfoView(infoTitle: "Total",
                                              infoMsg: "${double.parse("${orderDetailData?.items?.products?[index].quantity}") *
                                                  double.parse("${orderDetailData?.items?.products?[index].discountPrice}")}",),
                                            ]
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        index !=  orderDetailData!.items!.products!.length-1 ?
                        const Divider(height: 1, color: colorSeconary,) : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: colorSeconary.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NathanTextView(
                        text: "Order Status",
                        color: colorBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      NathanTextView(
                        text: "${orderDetailData?.items?.status}",
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  const Divider(height: 2,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NathanTextView(
                        text: "Currency",
                        color: colorBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      NathanTextView(
                        text: "$currency",
                        color: colorPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  const Divider(height: 2,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NathanTextView(
                        text: "Delivery Fee",
                        color: colorBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      NathanTextView(
                        text: money_format("${orderDetailData?.items?.deliveryFees}"),
                        color: colorBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  const Divider(height: 2,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NathanTextView(
                        text: "Sub Total",
                        color: colorBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      NathanTextView(
                        text: "${orderDetailData?.subTotal}",
                        color: colorBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  const Divider(height: 2,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NathanTextView(
                        text: "Grand Total",
                        color: colorBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),

                      NathanTextView(
                        text: "${orderDetailData?.grandTotal}",
                        color: colorBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ],
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
