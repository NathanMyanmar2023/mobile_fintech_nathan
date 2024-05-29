import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/bloc/top_up/phone_bill_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/views/screens/history/phone_bill_history/phone_bill_history_selector_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhoneBillHistoryScreen extends StatefulWidget {
  const PhoneBillHistoryScreen({
    super.key,
  });

  @override
  State<PhoneBillHistoryScreen> createState() =>
      _PhoneBillHistoryScreenState();
}

class _PhoneBillHistoryScreenState
    extends State<PhoneBillHistoryScreen> {
  bool isLoading = false;
  bool isFetching = false;
  final scroll_controller = ScrollController();

  final _phone_bill_bloc = PhoneBillBloc();
  late Stream<ResponseOb> _phone_bill_history_stream;
  //List<PhoneBillData> history_list = [];

  int page = 1;
  int limit = 20;
  bool hasMore = true;
  List history_list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _phone_bill_history_stream =
        _phone_bill_bloc.phoneBillStream();
    _phone_bill_history_stream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          // print("daal ${resp.data.data.length}");
          // history_list = (resp.data as PhoneBillOb).data ?? [];
          // print("hiiii 343 ${history_list.length}");
          for (var i = 0; i < resp.data.data.length; i++) {
            history_list.add([
              resp.data.data[i].id.toString(),
              resp.data.data[i].status,
              resp.data.data[i].amount,
              resp.data.data[i].phone,
              resp.data.data[i].operator,
              resp.data.data[i].date,
              resp.data.data[i].billed_time,
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
    _phone_bill_bloc.getPhoneBillHistory(page);
    if (isFetching) return;
    isFetching = true;
    if (hasMore == true) {
      //_phone_bill_bloc.getPhoneBillHistory(page);
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
                title: Text(
                  AppLocalizations.of(context)!.phone_bill_history,
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
                    return PhoneBillHistorySelectorWidget(
                      id: history[0].toString(),
                      status: history[1].toString(),
                      amount: history[2].toString(),
                      phone: history[3].toString(),
                      operator: history[4].toString(),
                      billed_time: history[6].toString(),
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

                  // return PhoneBillHistorySelectorWidget(
                  //   id: history[0].toString(),
                  //   status: history[1].toString(),
                  //   amount: history[2].toString(),
                  //   phone: history[3].toString(),
                  //   operator: history[4].toString(),
                  //   billed_time: history[6].toString(),
                  // );

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
