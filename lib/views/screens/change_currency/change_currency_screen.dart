import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fnge/bloc/deposit/currency_bloc.dart';
import 'package:fnge/bloc/wallet/change_wallet_type_bloc.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/resources/colors.dart';
import 'package:fnge/views/screens/change_currency/success_currency_change_screen.dart';
import 'package:fnge/widgets/long_button_view.dart';

import '../../widgets/error_alert_widget.dart';

class ChangeCurrencyScreen extends StatefulWidget {
  final String main_wallet_currency;
  const ChangeCurrencyScreen({
    super.key,
    required this.main_wallet_currency,
  });

  @override
  State<ChangeCurrencyScreen> createState() => _ChangeCurrencyScreenState();
}

class _ChangeCurrencyScreenState extends State<ChangeCurrencyScreen> {
  final _currency_bloc = CurrencyBloc();
  late Stream<ResponseOb> _currency_stream;

  final _change_wallet_type_bloc = ChangeWalletTypeBloc();
  late Stream<ResponseOb> _change_wallet_type_stream;

  //currency list
  List currency_list = [];

  String _currency = "1";
  int _currency_id = 1;

  int current_currency_id = 1;
  String current_currency = "-";
  String current_currency_country = "-";
  String current_currency_code = "-";

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currency_stream = _currency_bloc.currencyStream();
    _currency_stream.listen((ResponseOb resp) {
      if (resp.success) {
        for (var new_currency in resp.data.data) {
          if (new_currency.type.toString() != widget.main_wallet_currency) {
            setState(() {
              currency_list.add([
                new_currency.id,
                new_currency.name.toString(),
                new_currency.type.toString(),
                new_currency.code.toString()
              ]);
            });
          } else {
            setState(() {
              current_currency_id = new_currency.id;
              current_currency_country = new_currency.name.toString();
              current_currency_code = new_currency.code.toString();
              current_currency = new_currency.type.toString();
            });
          }
        }

        print(current_currency_id);

        if (current_currency_id == _currency_id) {
          setState(() {
            _currency_id = 2;
            _currency = "2";
          });
        }

        isLoading = false;
      } else {
        print("error");
      }
    });

    _change_wallet_type_stream =
        _change_wallet_type_bloc.changeWalletTypeStream();
    _change_wallet_type_stream.listen((ResponseOb resp) {
      if (resp.success) {
        isLoading = false;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) {
          return const SuccessCurrencyChangeScreen();
        }), (route) => false);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return ErrorAlert(
              "Oops !",
              Image.asset('images/welcome.png'),
              resp.message.toString(),
            );
          },
        );
        setState(() {
          isLoading = false;
        });
        return;
      }
    });

    _currency_bloc.getCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
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
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: AppBar(
              toolbarHeight: 70,
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: const Text(
                "Change Currency",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Flag.fromString(
                          current_currency_code,
                          height: 30,
                          width: 40,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              current_currency,
                              style: const TextStyle(
                                fontSize: 17, color: colorWhite,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              current_currency_country,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.teal.shade400,
                              ),
                            ),
                          ],
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                  child: Center(
                    child: Text("TO"),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: DropdownButton(
                        value: _currency,
                        hint: const Text("Select Country"),
                        iconSize: 35,
                        iconEnabledColor: Colors.blue,
                        isExpanded: true,
                        items: currency_list
                            .map((country) => DropdownMenuItem(
                                // ignore: sort_child_properties_last
                                child: SizedBox(
                                  height: 70,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Flag.fromString(
                                        country[3].toString(),
                                        height: 30,
                                        width: 40,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            country[2].toString(),
                                            style: const TextStyle(
                                              fontSize: 16, color: colorWhite,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            country[1].toString(),
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.teal.shade400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Expanded(
                                        child: SizedBox(),
                                      ),
                                    ],
                                  ),
                                ),
                                value: country[0].toString()))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _currency = value!;
                            _currency_id = int.parse(value);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                LongButtonView(
                    text: "Change Currency",
                    onTap: () {
                      Map<String, dynamic> map = {
                        'currency_id': _currency_id,
                      };
                      print(map);
                      _change_wallet_type_bloc.changeWalletType(map);
                      setState(() {
                        isLoading = true;
                      });
                    }),
                // MaterialButton(
                //   color: Colors.blue,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(45),
                //   ),
                //   height: 45,
                //   elevation: 0,
                //   onPressed: () {
                //     Map<String, dynamic> map = {
                //       'currency_id': _currency_id,
                //     };
                //     print(map);
                //     _change_wallet_type_bloc.changeWalletType(map);
                //     setState(() {
                //       isLoading = true;
                //     });
                //   },
                //   child: const SizedBox(
                //     height: 20,
                //     child: Center(
                //         child: Text(
                //       'Change Currency',
                //       style: TextStyle(
                //         color: Colors.white,
                //       ),
                //     )),
                //   ),
                // ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
