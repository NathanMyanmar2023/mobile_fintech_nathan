import 'package:flutter/material.dart';
import 'package:nathan_app/bloc/order_list_bloc.dart';
import 'package:nathan_app/extensions/navigation_extensions.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/order_list_ob.dart';
import 'package:nathan_app/pages/order_detail_page.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  final _orderListBloc = OrderListBloc();
  late Stream<ResponseOb> _orderListStream;
  List<OrderListData> orderList = [];

  @override
  void initState() {
    super.initState();

    /// order list stream
    _orderListStream = _orderListBloc.orderListStream();
    _orderListStream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          orderList = (resp.data as OrderListOb).data ?? [];
        });
      } else {}
    });

    _orderListBloc.orderList();
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
              "Order List",
              style: TextStyle(
                fontSize: 16,
                color: colorPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
      body: orderList.isEmpty ? Center(child: Text(
                  AppLocalizations.of(context)!.no_more_data,),
              ) : ListView.builder(
        padding: const EdgeInsets.only(bottom: 12),
        itemCount: orderList.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () =>
            navigateToNextPage(
              context: context,
              nextPage: OrderDetailPage(orderId: orderList[index].orderId),
            ),
          child: Card(
            margin: const EdgeInsets.only(top: 12, left: 16, right: 16),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderList[index].orderId ?? "-",
                    style: const TextStyle(
                      color: colorPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    orderList[index].status ?? "-",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    orderList[index].data ?? "-",
                    style: const TextStyle(
                      color: colorGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
