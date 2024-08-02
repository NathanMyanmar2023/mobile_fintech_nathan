import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:fnge/bloc/exchange/current_currency_bloc.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/resources/colors.dart';
import 'package:fnge/views/screens/exchange/confirm_exchange_screen.dart';
import 'package:fnge/views/widgets/error_alert_widget.dart';
import 'package:fnge/widgets/long_button_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/app_bar_title_view.dart';
import '../../Ads_banner/ads_banner_widget.dart';

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({super.key});

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  bool isLoading = false;
  var amount_tec = TextEditingController();
  var change_amount_tec = TextEditingController();

  //Initial Datas
  String balance = "0.00";
  String usd_balance = "0.00";
  String currency = "- -";
  String country = "- -";
  String sell_rate = "0.00";
  String buy_rate = "0.00";
  String country_code = "US";

  bool to_main_wallet = false;

  final _current_currency_bloc = CurrentCurrencyBloc();
  late Stream<ResponseOb> _current_currency_stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _current_currency_stream = _current_currency_bloc.currencyStream();
    _current_currency_stream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          balance = resp.data.data.balance;
          usd_balance = resp.data.data.usdBalance;
          currency = resp.data.data.currencyType;
          country = resp.data.data.currencyName;
          sell_rate = resp.data.data.sellRate;
          buy_rate = resp.data.data.buyRate;
          country_code = resp.data.data.countryCode;
        });
      } else {
        print("error");
      }
    });

    _current_currency_bloc.getCurrentCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: SpinKitFadingFour(
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
              text: AppLocalizations.of(context)!.wallet_exchange,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const AdsBannerWidget(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: const Icon(
                            Iconic.exchange,
                            size: 25,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .currency_exchange_rate,
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "1.00",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  " ${AppLocalizations.of(context)!.usd}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "  =  ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  sell_rate,
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  currency,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          onPressed: () {
                            setState(() {
                              to_main_wallet = false;
                              amount_tec.text = "";
                              change_amount_tec.text = "";
                            });
                          },
                          color: !to_main_wallet
                              ? colorPrimary
                              : Colors.grey.shade100,
                          child: Row(
                            children: [
                              Container(
                                child: const Flag.fromString(
                                  'US',
                                  height: 25,
                                  width: 35,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.to_usd,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: !to_main_wallet
                                          ? Colors.white
                                          : Colors.grey.shade800,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.sec_wallet,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: !to_main_wallet
                                          ? Colors.white
                                          : Colors.grey.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          elevation: 0,
                          onPressed: () {
                            setState(() {
                              to_main_wallet = true;
                              amount_tec.text = "";
                              change_amount_tec.text = "";
                            });
                          },
                          color: to_main_wallet
                              ? colorPrimary
                              : Colors.grey.shade100,
                          child: Row(
                            children: [
                              Container(
                                child: Flag.fromString(
                                  country_code,
                                  height: 25,
                                  width: 35,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.to} $currency',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: to_main_wallet
                                          ? Colors.white
                                          : Colors.grey.shade800,
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.main_wallet,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: to_main_wallet
                                          ? Colors.white
                                          : Colors.grey.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: !to_main_wallet,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .main_wallet_balance,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: colorWhite,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    balance,
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: colorWhite,
                                    ),
                                  ),
                                  Text(
                                    currency,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      color: colorWhite,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                country,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: colorWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            AppLocalizations.of(context)!.exchange_amt,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
                                    if (value != "") {
                                      change_amount_tec.text =
                                          (double.parse(amount_tec.text) /
                                                  double.parse(sell_rate))
                                              .toStringAsFixed(4);
                                    } else {
                                      change_amount_tec.text = "";
                                    }
                                  },
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}'),
                                    ),
                                  ],
                                  controller: amount_tec,
                                  decoration: InputDecoration(
                                    hintText: sell_rate,
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                  ),
                                  obscureText: false,
                                ),
                              ),
                              Text(
                                currency,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: Flag.fromString(
                                  country_code,
                                  height: 35,
                                  width: 40,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: Icon(
                            Icons.arrow_downward,
                            size: 25,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: TextField(
                                  readOnly: true,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  controller: change_amount_tec,
                                  decoration: const InputDecoration(
                                    hintText: "1 ",
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 14),
                                  ),
                                  obscureText: false,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)!.usd,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: const Flag.fromString(
                                  'US',
                                  height: 35,
                                  width: 40,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: to_main_wallet,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.sec_wallet,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: colorWhite,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    usd_balance,
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: colorWhite,
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.usd,
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: colorWhite,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                AppLocalizations.of(context)!.united_state,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: colorWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            AppLocalizations.of(context)!.exchange_amt,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
                                    if (value != "") {
                                      change_amount_tec.text =
                                          (double.parse(amount_tec.text) *
                                                  double.parse(buy_rate))
                                              .toStringAsFixed(2);
                                    } else {
                                      change_amount_tec.text = "";
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  controller: amount_tec,
                                  decoration: const InputDecoration(
                                    hintText: '1',
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 14),
                                  ),
                                  obscureText: false,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)!.usd,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: const Flag.fromString(
                                  'US',
                                  height: 35,
                                  width: 40,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                          child: Icon(
                            Icons.arrow_downward,
                            size: 25,
                            color: colorPrimary,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: TextField(
                                  readOnly: true,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  controller: change_amount_tec,
                                  decoration: InputDecoration(
                                    hintText: buy_rate,
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                  ),
                                  obscureText: false,
                                ),
                              ),
                              Text(
                                currency,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flag.fromString(
                                country_code,
                                height: 35,
                                width: 40,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  LongButtonView(
                      text: AppLocalizations.of(context)!.exchange,
                      onTap: () {
                        if (amount_tec.text != "") {
                          if (double.parse(amount_tec.text) <
                              double.parse(
                                      to_main_wallet ? usd_balance : balance) +
                                  1) {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return ConfirmExchangeScreen(
                                from_amount: amount_tec.text,
                                to_amount: change_amount_tec.text,
                                from_country_code:
                                    to_main_wallet ? 'US' : country_code,
                                to_country_code:
                                    !to_main_wallet ? 'US' : country_code,
                                from_currency:
                                    to_main_wallet ? 'USD' : currency,
                                to_currency: !to_main_wallet ? 'USD' : currency,
                                to_main_wallet: to_main_wallet,
                              );
                            }));
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return ErrorAlert(
                                  "Oops !",
                                  Image.asset('images/welcome.png'),
                                  AppLocalizations.of(context)!
                                      .u_dont_have_enought_balance,
                                );
                              },
                            );
                            return;
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ErrorAlert(
                                "Oops !",
                                Image.asset('images/welcome.png'),
                                AppLocalizations.of(context)!
                                    .amt_field_required,
                              );
                            },
                          );
                          return;
                        }
                      }),
                  const SizedBox(
                    height: 70,
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
