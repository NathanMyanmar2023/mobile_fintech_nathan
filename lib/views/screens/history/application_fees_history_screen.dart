import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/bloc/application_fees_history_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/application_fee_ob.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/widgets/application_fees_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ApplicationFeesHistoryScreen extends StatefulWidget {
  const ApplicationFeesHistoryScreen({
    super.key,
  });

  @override
  State<ApplicationFeesHistoryScreen> createState() =>
      _ApplicationFeesHistoryScreenState();
}

class _ApplicationFeesHistoryScreenState
    extends State<ApplicationFeesHistoryScreen> {
  bool isLoading = false;
  bool isFetching = false;
  final scroll_controller = ScrollController();

  final _application_fees_history_bloc = ApplicationFeesHistoryBloc();
  late Stream<ResponseOb> _application_fee_history_stream;

  int page = 1;
  int limit = 20;
  bool hasMore = true;

  List<ApplicationFeeData> history_list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _application_fee_history_stream =
        _application_fees_history_bloc.applicationFeesStream();
    _application_fee_history_stream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          history_list = (resp.data as ApplicationFeeOb).data ?? [];
          isLoading = false;
          page++;
          isFetching = false;
          if (resp.data.data.length < limit) {
            hasMore = false;
          }
        });
      } else {
        setState(() {
          isLoading = false;
        });
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
      _application_fees_history_bloc.getApplicationFeesHistory(page);
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
                  AppLocalizations.of(context)!.application_fees_history,
                  style: const TextStyle(
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
                  final history = history_list[index];
                  return ApplicationFeesWidget(
                    data: history,
                  );
                  // if (index < history_list.length) {
                  //   final history = history_list[index];
                  //   return ApplicationFeesWidget(
                  //     data: history,
                  //   );
                  // } else {
                  //   return Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 20, vertical: 20),
                  //     child: Center(
                  //       child: hasMore
                  //           ? const SizedBox(
                  //               width: 20,
                  //               height: 20,
                  //               child: CircularProgressIndicator(
                  //                 strokeWidth: 2,
                  //               ))
                  //           : Text(
                  //         AppLocalizations.of(context)!.no_more_data,
                  //               style: TextStyle(
                  //                 fontSize: 13,
                  //               ),
                  //             ),
                  //     ),
                  //   );
                  // }
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
