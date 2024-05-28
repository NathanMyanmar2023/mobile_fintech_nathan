import 'package:flutter/material.dart';
import 'package:flutter_app_version_checker/flutter_app_version_checker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/bloc/deposit/currency_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/widgets/currency_selector_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/app_bar_title_view.dart';
import '../../Ads_banner/ads_banner_widget.dart';

class DepositSelectCountryScreen extends StatefulWidget {
  final bool isForDeposit;
  final String main_wallet_balance;
  final String main_wallet_currency;

  const DepositSelectCountryScreen({
    super.key,
    required this.isForDeposit,
    required this.main_wallet_balance,
    required this.main_wallet_currency,
  });

  @override
  State<DepositSelectCountryScreen> createState() =>
      _DepositSelectCountryScreenState();
}

class _DepositSelectCountryScreenState
    extends State<DepositSelectCountryScreen> {
  final _currency_bloc = CurrencyBloc();
  late Stream<ResponseOb> _currency_stream;

  //currency list
  List currency_list = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _currency_stream = _currency_bloc.currencyStream();
    _currency_stream.listen((ResponseOb resp) {
      if (resp.success) {
        for (var new_currency in resp.data.data) {
          if (new_currency.type.toString() == widget.main_wallet_currency) {
            setState(() {
              currency_list.add([
                new_currency.id,
                new_currency.name.toString(),
                new_currency.type.toString(),
                new_currency.code.toString()
              ]);
            });
          }
        }

        isLoading = false;
      } else {
        print("error");
      }
    });

    _currency_bloc.getCurrencies();
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
            child: AppBarTitleView(text: widget.isForDeposit ? AppLocalizations.of(context)!.deposit: AppLocalizations.of(context)!.withdraw,),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AdsBannerWidget(paddingbottom: 0,),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: currency_list
                        .map((currency) => CurrencySelectorWidget(
                              country_name: currency[1],
                              currency_code: currency[2],
                              country_code: currency[3],
                              currency_id: currency[0],
                              isForDeposit: widget.isForDeposit,
                              main_wallet_balance: widget.main_wallet_balance,
                              main_wallet_currency: widget.main_wallet_currency,
                            ))
                        .toList(),
                  ),
                  const AdsBannerWidget(),
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
