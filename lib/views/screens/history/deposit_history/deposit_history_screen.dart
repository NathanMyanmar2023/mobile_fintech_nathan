import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fnge/bloc/history/deposit_history/deposit_history_bloc.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/resources/colors.dart';
import 'package:fnge/views/widgets/history/deposit_history_selector_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DepositHistoryScreen extends StatefulWidget {
  const DepositHistoryScreen({
    super.key,
  });

  @override
  State<DepositHistoryScreen> createState() => _DepositHistoryScreenState();
}

class _DepositHistoryScreenState extends State<DepositHistoryScreen> {
  bool isLoading = false;
  bool isFetching = false;
  final scroll_controller = ScrollController();

  final _deposit_history_bloc = DepositHistoryBloc();
  late Stream<ResponseOb> _deposit_history_stream;

  int page = 1;
  int limit = 20;
  bool hasMore = true;

  List history_list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _deposit_history_stream = _deposit_history_bloc.depositHistoryStream();
    _deposit_history_stream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          for (var i = 0; i < resp.data.data.length; i++) {
            history_list.add([
              resp.data.data[i].id.toString(),
              resp.data.data[i].amount.toString(),
              resp.data.data[i].status,
              resp.data.data[i].country,
              resp.data.data[i].currency,
              resp.data.data[i].paymentMethod,
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
        // log(history_list.toString());
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

    _deposit_history_bloc.getDepositHistory(page);
    if (isFetching) return;
    isFetching = true;
    if (hasMore == true) {
      // _deposit_history_bloc.getDepositHistory(page);
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
                  AppLocalizations.of(context)!.deposit_history,
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
              child: history_list.isEmpty
                  ? Center(
                      child: Text(
                        AppLocalizations.of(context)!.no_more_data,
                      ),
                    )
                  : ListView.builder(
                      controller: scroll_controller,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: history_list.length, //history_list.length + 1,
                      itemBuilder: (context, index) {
                        if (index < history_list.length) {
                          final history = history_list[index];
                          return DepositHistorySelectorWidget(
                            id: history[0],
                            amount: history[1],
                            status: history[2],
                            country: history[3],
                            currency: history[4],
                            payment_method: history[5],
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
                                  : Text(
                                      AppLocalizations.of(context)!
                                          .no_more_data,
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
