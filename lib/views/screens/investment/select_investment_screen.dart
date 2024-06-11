import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/bloc/investment_plan_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/investment_plan_ob.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/custom/snack_bar.dart';
import 'package:nathan_app/views/screens/investment/investment_screen.dart';
import 'package:nathan_app/widgets/long_button_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/app_bar_title_view.dart';
import '../../Ads_banner/ads_banner_widget.dart';

class SelectInvestmentScreen extends StatefulWidget {
  final String second_wallet_balance;

  const SelectInvestmentScreen(
      {super.key, required this.second_wallet_balance});

  @override
  State<SelectInvestmentScreen> createState() => _SelectInvestmentScreenState();
}

class _SelectInvestmentScreenState extends State<SelectInvestmentScreen> {
  final _investmentPlanBloc = InvestmentPlanBloc();
  late Stream<ResponseOb> _investmentPlanStream;

  //currency list
  List<Data?> investmentPlanList = [];

  bool isLoading = true;
  bool isSixMonth = false;

  @override
  void initState() {
    super.initState();

    _investmentPlanStream = _investmentPlanBloc.investmentPlanStream();
    _investmentPlanStream.listen((ResponseOb resp) {
      if (resp.success == true) {
        setState(() {
          investmentPlanList = InvestmentPlanOb.fromJson(resp.data).data ?? [];
        });
      } else {
        print("error");
      }

      setState(() {
        isLoading = false;
      });
    });

    // Map<String, String> map = {
    //   'amount': "22",
    //   'phone': "09777126169",
    //   'payment': "kapy",
    //   'bankAccOrTransferPhone': "xxxx44x4xxxx4345",
    // };
    _investmentPlanBloc.getInvestmentPlans();
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
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: AppBarTitleView(text: AppLocalizations.of(context)!.investment,),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 1 / 1,
                              child: InkWell(
                                onTap: () {
                                  if (isSixMonth) {
                                    setState(() {
                                      isSixMonth = false;
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: !isSixMonth
                                          ? colorPrimary
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset(
                                      'images/customer.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            investmentPlanList[0]?.promotion?.isAvailable != true ? const SizedBox() : Positioned(
                              top: 2,
                              right: 3,
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red.withOpacity(
                                      0.8,
                                    ),
                                  ),
                                padding: const EdgeInsets.only(right: 5, top: 5, left: 8, bottom: 5),
                                  child: const Text("Promotion", style: TextStyle(color: Colors.white),)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 1 / 1,
                              child: InkWell(
                                onTap: () {
                                  if (!isSixMonth) {
                                    setState(() {
                                      isSixMonth = true;
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: isSixMonth
                                          ? colorPrimary
                                          : Colors.grey.shade100,
                                      width: 3,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset(
                                      'images/distributor.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            investmentPlanList[1]?.promotion?.isAvailable != true ? const SizedBox() : Positioned(
                              top: 2,
                              right: 3,
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red.withOpacity(
                                      0.8,
                                    ),
                                  ),
                                  padding: const EdgeInsets.only(right: 5, top: 5, left: 8, bottom: 5),
                                  child: const Text("Promotion", style: TextStyle(color: Colors.white),)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          investmentPlanList[0]?.name ?? "-",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: !isSixMonth
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: Text(
                          investmentPlanList[1]?.name ?? "-",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: isSixMonth
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (!isSixMonth)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          investmentPlanList[0]?.name ?? "-",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          investmentPlanList[0]?.description ?? "-",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          investmentPlanList[1]?.name ?? "-",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          investmentPlanList[1]?.description ?? "-",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                  LongButtonView(
                      text: AppLocalizations.of(context)!.next,
                      onTap: () {
                        isSixMonth ? investmentPlanList[1]?.isAllow == 0 ?
                        context.showSnack(AppLocalizations.of(context)!.sry_accept_trans_error_msg,
                          Colors.white,
                          Colors.red,
                          Icons.close,
                        ) :
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return InvestmentScreen(
                            isSixMonth: isSixMonth,
                            second_wallet_balance: widget.second_wallet_balance,
                            investmentPlanId: (isSixMonth
                                ? investmentPlanList[1]?.id
                                : investmentPlanList[0]?.id) ??
                                0,
                            investmentType: (isSixMonth
                                ? investmentPlanList[1]?.name
                                : investmentPlanList[0]?.name) ??
                                "-",
                            percentage: (isSixMonth
                                ? investmentPlanList[1]?.profit
                                : investmentPlanList[0]?.profit) ??
                                0,
                            promotionName: (isSixMonth
                                ? investmentPlanList[1]?.promotion?.name
                                : investmentPlanList[0]?.promotion?.name) ??
                                "-",
    promotionAmt: (isSixMonth
                                  ? investmentPlanList[1]?.promotion?.amount
                                  : investmentPlanList[0]?.promotion?.amount) ??
                                  "-",
    promotionStartDate: (isSixMonth
                                  ? investmentPlanList[1]?.promotion?.startDate
                                  : investmentPlanList[0]?.promotion?.startDate) ??
                                  "-",
    promotionEndDate: (isSixMonth
                                  ? investmentPlanList[1]?.promotion?.endDate
                                  : investmentPlanList[0]?.promotion?.endDate) ??
                                  "-",
                            promotionMinInve: (isSixMonth
                                ? investmentPlanList[1]?.promotion?.minInvestAmount
                                : investmentPlanList[0]?.promotion?.minInvestAmount) ?? 0,
                            promotionNetworkAmt: (isSixMonth
                                ? investmentPlanList[1]?.promotion?.networkPercentage
                                : investmentPlanList[0]?.promotion?.networkPercentage) ?? "-",
                            isPromotion: (isSixMonth
                                ? investmentPlanList[1]?.promotion?.isAvailable == true ? true : false
                                : investmentPlanList[0]?.promotion?.isAvailable == true  ? true : false),
                          );
                       }))
                        :
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return InvestmentScreen(
                            isSixMonth: isSixMonth,
                            second_wallet_balance: widget.second_wallet_balance,
                            investmentPlanId: (isSixMonth
                                    ? investmentPlanList[1]?.id
                                    : investmentPlanList[0]?.id) ??
                                0,
                            investmentType: (isSixMonth
                                    ? investmentPlanList[1]?.name
                                    : investmentPlanList[0]?.name) ??
                                "-",
                            percentage: (isSixMonth
                                    ? investmentPlanList[1]?.profit
                                    : investmentPlanList[0]?.profit) ??
                                0,
                              promotionName: (isSixMonth
                                  ? investmentPlanList[1]?.promotion?.name
                                  : investmentPlanList[0]?.promotion?.name) ??
                                  "-",
    promotionAmt: (isSixMonth
                                  ? investmentPlanList[1]?.promotion?.amount
                                  : investmentPlanList[0]?.promotion?.amount) ??
                                  "-",
                            promotionMinInve: (isSixMonth
                                ? investmentPlanList[1]?.promotion?.minInvestAmount
                                : investmentPlanList[0]?.promotion?.minInvestAmount) ?? 0,
                            promotionNetworkAmt: (isSixMonth
                                ? investmentPlanList[1]?.promotion?.networkPercentage
                                : investmentPlanList[0]?.promotion?.networkPercentage) ?? "-",
    promotionStartDate: (isSixMonth
                                  ? investmentPlanList[1]?.promotion?.startDate
                                  : investmentPlanList[0]?.promotion?.startDate) ??
                                  "-",
    promotionEndDate: (isSixMonth
                                  ? investmentPlanList[1]?.promotion?.endDate
                                  : investmentPlanList[0]?.promotion?.endDate) ??
                                  "-",
                              isPromotion: (isSixMonth
                                  ? investmentPlanList[1]?.promotion?.isAvailable == true ? true : false
                                  : investmentPlanList[0]?.promotion?.isAvailable == true  ? true : false),
                          );
                        }));
                      }),
                 // const AdsBannerWidget(paddingbottom: 0,),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
