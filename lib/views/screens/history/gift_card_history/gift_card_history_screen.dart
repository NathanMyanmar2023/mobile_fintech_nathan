import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../bloc/history/gift_card_history/gift_card_history_bloc.dart';
import 'gift_card_history_selector_widget.dart';

class GiftCardHistoryScreen extends StatefulWidget {
  const GiftCardHistoryScreen({
    super.key,
  });

  @override
  State<GiftCardHistoryScreen> createState() =>
      _GiftCardHistoryScreenState();
}

class _GiftCardHistoryScreenState
    extends State<GiftCardHistoryScreen> {
  bool isLoading = false;
  bool isFetching = false;
  final scroll_controller = ScrollController();

  final _giftCard_history_bloc = GiftCardHistoryBloc();
  late Stream<ResponseOb> _giftCardhistory_stream;

  int page = 1;
  int limit = 20;
  bool hasMore = true;
  List history_list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _giftCardhistory_stream =
        _giftCard_history_bloc.giftCardHistoryStream();
    _giftCardhistory_stream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          print("TranLen ${resp.data.data.transactions.length}");
          for (var i = 0; i < resp.data.data.transactions.length; i++) {
            history_list.add([
              resp.data.data.transactions[i].id.toString(),
              resp.data.data.transactions[i].userId,
              resp.data.data.transactions[i].tag,
              resp.data.data.transactions[i].playerId,
              resp.data.data.transactions[i].serverId,
              resp.data.data.transactions[i].giftCardAmount,
              resp.data.data.transactions[i].unit,
              resp.data.data.transactions[i].priceMmk,
              resp.data.data.transactions[i].status,
              resp.data.data.transactions[i].remarks,
              resp.data.data.transactions[i].purchasedTime,
              resp.data.data.transactions[i].completedTime,
              resp.data.data.transactions[i].createdAt,
              resp.data.data.transactions[i].updatedAt,
            ]);
          }
          isLoading = false;
          page++;
          isFetching = false;
          if (resp.data.data.transactions.length < limit) {
            hasMore = false;
          }
        });
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
    print(hasMore);
    if (isFetching) return;
    isFetching = true;
    if (hasMore == true) {
     _giftCard_history_bloc.getGiftCardHistoryHistory();
      print("getting page - $page");
    }
  }

  Future refersh() async {
    setState(() {
      isFetching = false;
      hasMore = true;
      page = 1;
      history_list.clear();
    });

    fetch();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SpinKitFadingFour(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index.isEven ? Colors.blue : Colors.grey.shade800,
                ),
              );
            },
          ),
        ),
      );
    } else {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: AppBar(
                toolbarHeight: 70,
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: const Text(
                  "Gift Card History",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            body: RefreshIndicator(
              onRefresh: refersh,
              child: history_list.isEmpty ? Center(child: Text(AppLocalizations.of(context)!.no_more_data,),) : ListView.builder(
                controller: scroll_controller,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: history_list.length,
                itemBuilder: (context, index) {
                  final history = history_list[index];
                  if (index < history_list.length) {
                    return GiftCardHistorySelectorWidget(
                      id: history[0].toString(),
                      userId: history[1].toString(),
                      tag: history[2].toString(),
                      playerId: history[3].toString(),
                      serverId: history[4].toString(),
                      giftCardAmount: history[5].toString(),
                      unit: history[6].toString(),
                      priceMmk: history[7].toString(),
                      status: history[8].toString(),
                      remarks: history[9] ?? "",
                      purchasedTime: history[10].toString(),
                      completedTime: history[11] ?? "",
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
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            )),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scroll_controller.dispose();
  }
}
