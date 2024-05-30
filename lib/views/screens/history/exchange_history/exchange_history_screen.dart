import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/bloc/history/exchange_history/exchange_history_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/widgets/history/exchange_history_selector_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExchangeHistoryScreen extends StatefulWidget {
  const ExchangeHistoryScreen({
    super.key,
  });

  @override
  State<ExchangeHistoryScreen> createState() => _ExchangeHistoryScreenState();
}

class _ExchangeHistoryScreenState extends State<ExchangeHistoryScreen> {
  bool isLoading = false;
  bool isFetching = false;
  final scroll_controller = ScrollController();

  final _exchange_history_bloc = ExchangeHistoryBloc();
  late Stream<ResponseOb> _exchange_history_stream;

  int page = 1;
  int limit = 20;
  bool hasMore = true;

  List history_list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _exchange_history_stream = _exchange_history_bloc.exchangeHistoryStream();
    _exchange_history_stream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          for (var i = 0; i < resp.data.data.length; i++) {
            history_list.add([
              resp.data.data[i].id.toString(),
              resp.data.data[i].isToMainWallet,
              resp.data.data[i].fromAmount,
              resp.data.data[i].fromCurrency,
              resp.data.data[i].toAmount,
              resp.data.data[i].toCurrency,
              resp.data.data[i].createdAt,
            ]);
          }
          isLoading = false;
          page++;
          isFetching = false;
          if (resp.data.data.length < limit) {
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

    _exchange_history_bloc.getExchangeHistory(page);
    if (isFetching) return;
    isFetching = true;
    if (hasMore == true) {
    //  _exchange_history_bloc.getExchangeHistory(page);
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
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
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
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: AppBar(
                toolbarHeight: 70,
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: colorPrimary),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(
                  AppLocalizations.of(context)!.exchange_history,
                  style: TextStyle(
                    fontSize: 18,
                    color: colorPrimary,
                    fontWeight: FontWeight.w800,
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
                  if (index < history_list.length) {
                    final history = history_list[index];
                    return ExchangeHistorySelectorWidget(
                      id: history[0],
                      is_to_main_wallet: history[1],
                      from_amount: history[2],
                      from_currency: history[3],
                      to_amount: history[4],
                      to_currency: history[5],
                      created_at: history[6],
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
                            :  Text(
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
