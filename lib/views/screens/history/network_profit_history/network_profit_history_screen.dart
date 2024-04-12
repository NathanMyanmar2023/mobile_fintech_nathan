import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/bloc/history/network_profit_history/network_profit_history_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/history/network_profit_history_ob.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/widgets/history/network_profit_history_selector_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NetworkProfitHistoryScreen extends StatefulWidget {
  const NetworkProfitHistoryScreen({
    super.key,
  });

  @override
  State<NetworkProfitHistoryScreen> createState() =>
      _NetworkProfitHistoryScreenState();
}

class _NetworkProfitHistoryScreenState
    extends State<NetworkProfitHistoryScreen> {
  bool isLoading = false;
  bool isFetching = false;
  final scroll_controller = ScrollController();

  final _network_profit_history_bloc = NetworkProfitHistoryBloc();
  late Stream<ResponseOb> _network_profit_history_stream;

  int page = 1;
  int limit = 20;
  bool hasMore = true;

  List<NetworkProfitHistoryData> historyList = [];

  @override
  void initState() {
    super.initState();

    _network_profit_history_stream =
        _network_profit_history_bloc.networkProfitHistoryStream();
    _network_profit_history_stream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          historyList = (resp.data as NetworkProfitHistoryOb).data ?? [];
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

    _network_profit_history_bloc.getNetworkProfitHistory(page);
    if (isFetching) return;
    isFetching = true;
    if (hasMore == true) {
      _network_profit_history_bloc.getNetworkProfitHistory(page);
      print("getting page - $page");
    }
  }

  Future refersh() async {
    setState(() {
      isFetching = false;
      hasMore = true;
      page = 1;
      historyList.clear();
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
                  AppLocalizations.of(context)!.network_profit_history,
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
              child: historyList.isEmpty ? Center(child: Text(AppLocalizations.of(context)!.no_more_data,),) :  ListView.builder(
                controller: scroll_controller,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: historyList.length,
                itemBuilder: (context, index) {
                  if (index < historyList.length) {
                    final history = historyList[index];
                    return NetworkProfitHistorySelectorWidget(
                      data: history,
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
