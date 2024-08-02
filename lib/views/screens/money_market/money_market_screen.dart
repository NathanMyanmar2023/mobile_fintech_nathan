import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:fnge/bloc/money_market/bill_auction_bloc.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/resources/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../objects/money_market/bill_auction_ob.dart';
import '../../../widgets/app_bar_title_view.dart';
import '../../../widgets/nathan_text_view.dart';
import '../../../widgets/row_icon_text.dart';
import '../../Ads_banner/ads_banner_widget.dart';
import 'auction_round/start_round_detail_screen.dart';
import 'aution_group_screen.dart';
import 'bill_auction_joined_screen.dart';
import 'bill_auction_screen.dart';

class MoneyMarketScreen extends StatefulWidget {
  const MoneyMarketScreen({
    super.key,
  });

  @override
  State<MoneyMarketScreen> createState() => _MoneyMarketScreenState();
}

class _MoneyMarketScreenState extends State<MoneyMarketScreen> {
  bool isLoading = false;

  var amount_tec = TextEditingController();
  var note_tec = TextEditingController();
  var phone_tec = TextEditingController();
  String _phone_code = '+66';

  String transfer_note = "";

  final _billAuctionBloc = BillAuctionBloc();
  late Stream<ResponseOb> _billAuctionStream;
  List<BillAuctionData> billAuctionList = [];

  @override
  void initState() {
    super.initState();
    _billAuctionStream = _billAuctionBloc.billAuctionStream();
    _billAuctionStream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          billAuctionList = (resp.data as BillAuctionOb).data ?? [];
        });
      } else {}
    });

    _billAuctionBloc.getBillAuction();
  }

  bool isSixMonth = false;
  final scroll_controller = ScrollController();

  Future refersh() async {
    setState(() {
      print("odododo");
      _billAuctionBloc.getBillAuction();
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
              text: "Money Market",
            ),
          ),
          body: RefreshIndicator(
            onRefresh: refersh,
            child: billAuctionList.isEmpty
                ? Center(
                    child: Text(
                      AppLocalizations.of(context)!.no_more_data,
                    ),
                  )
                : Column(
                  children: [
                    const AdsBannerWidget(),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: ListView.builder(
                            controller: scroll_controller,
                            itemCount: billAuctionList.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: AspectRatio(
                                  aspectRatio: 5.5 / 2,
                                  child: Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (billAuctionList[index].stardardLimit ==
                                                  billAuctionList[index]
                                                      .existingUsers &&
                                              billAuctionList[index]
                                                      .authUserHasStatus ==
                                                  0) {
                                            print("can'");
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (co) => billAuctionList[
                                                                  index]
                                                              .authUserHasStatus ==
                                                          0
                                                      ? BillAuctionScreen(
                                                          auctionId:
                                                              billAuctionList[index]
                                                                      .id ??
                                                                  0,
                                                          auctionName:
                                                              "${billAuctionList[index].title}",
                                                          auctionAmt:
                                                              "${billAuctionList[index].amount}",
                                                        )
                                                      : billAuctionList[index]
                                                                  .existingUsers ==
                                                              10
                                                          ? AuctionGroupScreen(
                                                              auctionId:
                                                                  billAuctionList[
                                                                              index]
                                                                          .id ??
                                                                      0,
                                                            )
                                                          : BillAuctionJoinedScreen(
                                                              auctionId:
                                                                  billAuctionList[
                                                                              index]
                                                                          .id ??
                                                                      0,
                                                            ),
                                                ));
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: colorWhite,
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: billAuctionList[index]
                                                          .authUserHasStatus ==
                                                      0
                                                  ? colorPrimary
                                                  : colorSeconary.withOpacity(0.5),
                                              width: 3,
                                            ),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "${billAuctionList[index].title}",
                                                        style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${billAuctionList[index].amount}",
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w800,
                                                          color: colorPrimary,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  RowIconText(
                                                    icon: Icons.timer_outlined,
                                                    name:
                                                        "${billAuctionList[index].startMonth}",
                                                  ),
                                                  RowIconText(
                                                    icon: Icons.group,
                                                    name:
                                                        "${billAuctionList[index].stardardLimit} persons",
                                                  ),
                                                  billAuctionList[index]
                                                              .stardardLimit ==
                                                          billAuctionList[index]
                                                              .existingUsers
                                                      ? const SizedBox()
                                                      : RowIconText(
                                                          icon: Icons
                                                              .person_add_alt_1_outlined,
                                                          name:
                                                              "${billAuctionList[index].leftUser} ${billAuctionList[index].leftUser! > 1 ? "persons" : "person"}",
                                                        ),
                                                ],
                                              )),
                                        ),
                                      ),
                                      billAuctionList[index].leftUser! > 0 &&
                                              billAuctionList[index]
                                                      .authUserHasStatus ==
                                                  0
                                          ? const SizedBox()
                                          : Positioned(
                                              bottom: 15,
                                              right: 10,
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 10, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color:
                                                      colorSeconary.withOpacity(0.3),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: NathanTextView(
                                                  text: billAuctionList[index]
                                                                  .leftUser! ==
                                                              0 &&
                                                          billAuctionList[index]
                                                                  .authUserHasStatus ==
                                                              0
                                                      ? "Locked"
                                                      : "Joined",
                                                  fontSize: 15,
                                                  color: billAuctionList[index]
                                                                  .leftUser! ==
                                                              0 &&
                                                          billAuctionList[index]
                                                                  .authUserHasStatus ==
                                                              0
                                                      ? Colors.red
                                                      : Colors.green,
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
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
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scroll_controller.dispose();
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
