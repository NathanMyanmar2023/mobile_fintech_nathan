import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/bloc/money_market/auction_detail_bloc.dart';
import 'package:nathan_app/bloc/money_market/auction_leave_bloc.dart';
import 'package:nathan_app/resources/colors.dart';
import '../../../bloc/money_market/auction_insterest_bloc.dart';
import '../../../helpers/response_ob.dart';
import '../../../objects/money_market/auction_detail_ob.dart';
import '../../../widgets/app_bar_title_view.dart';
import '../../../widgets/nathan_text_view.dart';
import '../../Ads_banner/ads_banner_widget.dart';

class AllMemberView extends StatefulWidget {
  final int auctionId;
  const AllMemberView({required this.auctionId,
    Key? key})
      : super(key: key);

  @override
  State<AllMemberView> createState() => _AllMemberViewState();
}

class _AllMemberViewState extends State<AllMemberView> {
  bool isLoading = false;
  bool _agreeVisible = true;
  final scroll_controller = ScrollController();

  Future refersh() async {
    setState(() {});
  }
  final _auctionDetailBloc = AuctionDetailBloc();
  late Stream<ResponseOb> _auctionDetailStream;
  List<BillAuctionUserLists> billAuctionUserLists = [];

  final _auctionInstBloc = AuctionInsterestBloc();
  late Stream<ResponseOb> _auctionInsteStream;

  final _auctionLeaveBloc = AuctionLeaveBloc();
  late Stream<ResponseOb> _auctionLeaveStream;

  String title = "";
  String description = "";
  String amount = "";
  int limitCount = 0;
  int existingUsers = 0;
  int leftUser = 10;
  @override
  void initState() {
    super.initState();
    _auctionDetailBloc.getAuctionDetail(widget.auctionId);
    _auctionDetailStream = _auctionDetailBloc.auctionDetailStream();
    _auctionDetailStream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          title = resp.data.data.title;
          description = resp.data.data.description;
          amount = resp.data.data.amount;
          limitCount = resp.data.data.stardardLimit;
          leftUser = resp.data.data.leftUser;
          existingUsers = resp.data.data.existingUsers;
          billAuctionUserLists = (resp.data as AuctionDetailOb).data!.billAuctionUserLists ?? [];
        });
      } else {}
    });
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
            child: AppBarTitleView(
              text: "All Members",
            ),
          ),
          body: RefreshIndicator(
            onRefresh: refersh,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  const AdsBannerWidget(),
                  Expanded(
                    child: SingleChildScrollView(
                      child:  ListView.builder(
                        controller: scroll_controller,
                        itemCount: billAuctionUserLists.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: colorPrimary.withOpacity(0.8),
                                        child: const Icon(Icons.person, color: colorWhite, size: 25,),
                                      ),
                                      const SizedBox(width: 10,),
                                      Expanded(child: NathanTextView(text: "${billAuctionUserLists[index].username}",)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
