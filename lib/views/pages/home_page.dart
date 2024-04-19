import 'package:flutter/material.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nathan_app/bloc/wallets_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/itemviews/wallet_item_view.dart';
import 'package:nathan_app/models/utils/app_utils.dart';
import 'package:nathan_app/pages/lucky_draw_page.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/screens/deposit/deposit_select%20_country_screen.dart';
import 'package:nathan_app/views/screens/exchange/exchange_screen.dart';
import 'package:nathan_app/views/screens/investment/select_investment_screen.dart';
import 'package:nathan_app/views/screens/kyc/kyc_screen.dart';
import 'package:nathan_app/views/screens/main_screen.dart';
import 'package:nathan_app/views/screens/transfer/transfer_screen.dart';
import 'package:nathan_app/views/screens/welcome_screen.dart';
import 'package:nathan_app/views/widgets/main_menu_button_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../bloc/user_info_bloc.dart';
import '../../helpers/shared_pref.dart';
import '../screens/money_market/money_market_screen.dart';
import '../screens/shopping/category_screen.dart';
import '../screens/top_up/top_up_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  //wallet card controller
  final _wallet_card_controller = PageController();
  final scroll_controller = ScrollController();

  final _wallets_bloc = WalletsBloc();
  late Stream<ResponseOb> _wallets_stream;

  //Initial Data for wallets
  String main_wallet_amount = "0.00";
  String main_wallet_balance = "0.00";
  String main_wallet_currency = "...";
  String main_wallet_country = "...";

  String usd_wallet_amount = "0.00";
  String usd_wallet_balance = "0.00";

  String investment_wallet_amount = "0.00";

  final _user_info_bloc = UserInfoBloc();
  late Stream<ResponseOb> _user_info_stream;

  // String network_wallet_amount = "0.00";

  //End Initial data for wallets

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _wallets_stream = _wallets_bloc.walletsStream();
    _wallets_stream.listen((ResponseOb resp) {
      if (resp.authorized == false) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) {
          return const WelcomeScreen();
        }), (route) => false);
        return;
      }
      if (resp.success) {
        setState(() {
          main_wallet_amount =
              AppUtils().formatAsMoney(resp.data.data.mainWalletAmount);
          main_wallet_balance = resp.data.data.mainWalletAmount;
          main_wallet_country = resp.data.data.mainWalletCurrencyName;
          main_wallet_currency = resp.data.data.mainWalletCurrencyType;
          usd_wallet_amount =
              AppUtils().formatAsMoney(resp.data.data.usdWalletAmount);
          usd_wallet_balance = resp.data.data.usdWalletAmount;
          investment_wallet_amount =
              AppUtils().formatAsMoney(resp.data.data.investmentWalletAmount);
          // network_wallet_amount =
          //     AppUtils().formatAsMoney(resp.data.data.networkWalletAmount);

          SharedPref.setData(
            key: SharedPref.currency,
            value: resp.data.data.mainWalletCurrencyType,
          );
        });

        //USER INFO
        _user_info_stream = _user_info_bloc.userInfoStream();
        _user_info_stream.listen((ResponseOb resp) {
          if (resp.success) {
            setState(() {
              MainScreen.kyc_message = resp.data.data.kyc_message;
            });
          }});
      } else {
        print("error");
      }
    });

    _wallets_bloc.getWallets();
  }

  Future refersh() async {
    _wallets_bloc.getWallets();
    _user_info_bloc.getUserInfos();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: RefreshIndicator(
          onRefresh: refersh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: scroll_controller,
            child: Column(
              children: [
                if (MainScreen.is_kyc != "1")
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Material(
                      color:
                          MainScreen.is_kyc == "2" || MainScreen.is_kyc == "3"
                              ? Colors.red.withAlpha(40)
                              : Colors.orange.withAlpha(50),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Row(
                            children: [
                              if (MainScreen.is_kyc == "3" ||
                                  MainScreen.is_kyc == "2")
                                const Icon(
                                  Icons.info_outline,
                                  color: Colors.red,
                                ),
                              if (MainScreen.is_kyc == "0")
                                const Icon(
                                  Icons.access_time_rounded,
                                  color: Colors.orange,
                                ),
                              const SizedBox(
                                width: 10,
                              ),
                              if (MainScreen.is_kyc == "3")
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    AppLocalizations.of(context)!.kyc_info,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              if (MainScreen.is_kyc == "2")
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    AppLocalizations.of(context)!
                                        .reject_kyc_info,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              if (MainScreen.is_kyc == "0")
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: Text(
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    AppLocalizations.of(context)!
                                        .review_kyc_info,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              const Expanded(child: SizedBox()),
                              if (MainScreen.is_kyc == "3" ||
                                  MainScreen.is_kyc == "2")
                                MaterialButton(
                                  color: colorPrimary,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return const KycScreen();
                                    }));
                                  },
                                  child: Text(
                                    MainScreen.is_kyc == "3"
                                        ? AppLocalizations.of(context)!.upload
                                        : AppLocalizations.of(context)!
                                            .upload_again,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                if (MainScreen.is_kyc != "1")
                  const SizedBox(
                    height: 20,
                  ),
                if (MainScreen.is_kyc == "1")
                  MainScreen.kyc_message.length > 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Material(
                            color: Colors.orange.withAlpha(50),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.notifications,
                                    color: Colors.orange,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.3,
                                    child: Text(
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                      textAlign: TextAlign.center,
                                      maxLines: 10,
                                      MainScreen.kyc_message,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                SizedBox(
                  height: 160,
                  child: PageView(
                    controller: _wallet_card_controller,
                    scrollDirection: Axis.horizontal,
                    children: [
                      WalletItemView(
                        walletType: AppLocalizations.of(context)!.main_wallet,
                        balance: main_wallet_amount,
                        currency: main_wallet_currency,
                        country: main_wallet_country,
                      ),
                      WalletItemView(
                        walletType: AppLocalizations.of(context)!.usd_wallet,
                        balance: usd_wallet_amount,
                        currency: AppLocalizations.of(context)!.usd,
                        country: AppLocalizations.of(context)!.united_state,
                      ),
                      WalletItemView(
                        walletType: AppLocalizations.of(context)!.invest_wallet,
                        balance: investment_wallet_amount,
                        currency: AppLocalizations.of(context)!.usd,
                        country: AppLocalizations.of(context)!.united_state,
                      ),
                      // if (MainScreen.role == '1')
                      //   WalletItemView(
                      //     walletType: 'Network Benefit',
                      //     balance: network_wallet_amount,
                      //     currency: main_wallet_currency,
                      //     country: main_wallet_country,
                      //   ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SmoothPageIndicator(
                  controller: _wallet_card_controller,
                  count: MainScreen.role == '1' ? 3 : 3,
                  effect: ExpandingDotsEffect(
                    expansionFactor: 2,
                    activeDotColor: Colors.grey.shade600,
                    dotColor: Colors.grey.shade400,
                    dotWidth: 10,
                    dotHeight: 10,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainMenuButtonWidget(
                        menu_icon: const Icon(
                          Linecons.wallet,
                          color: colorWhite,
                        ),
                        menu_name: AppLocalizations.of(context)!.deposit,
                        target_page: DepositSelectCountryScreen(
                          isForDeposit: true,
                          main_wallet_balance: main_wallet_balance,
                          main_wallet_currency: main_wallet_currency,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MainMenuButtonWidget(
                        menu_icon: const Icon(
                          Iconic.exchange,
                          color: colorWhite,
                        ),
                        menu_name: AppLocalizations.of(context)!.exchange,
                        target_page: const ExchangeScreen(),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MainMenuButtonWidget(
                        menu_icon: const Icon(
                          Icons.account_balance_outlined,
                          color: colorWhite,
                        ),
                        menu_name: AppLocalizations.of(context)!.investment,
                        target_page: SelectInvestmentScreen(
                          second_wallet_balance: usd_wallet_balance,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MainMenuButtonWidget(
                        menu_icon: const Icon(
                          Linecons.money,
                          color: colorWhite,
                        ),
                        menu_name: AppLocalizations.of(context)!.withdraw,
                        target_page: DepositSelectCountryScreen(
                          isForDeposit: false,
                          main_wallet_balance: main_wallet_balance,
                          main_wallet_currency: main_wallet_currency,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainMenuButtonWidget(
                        menu_icon: const Icon(
                          Icons.send,
                          color: colorWhite,
                        ),
                        menu_name: AppLocalizations.of(context)!.transfer,
                        target_page: TransferScreen(
                          main_wallet_balance: main_wallet_balance,
                          main_wallet_country: main_wallet_country,
                          main_wallet_currency: main_wallet_currency,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // MainMenuButtonWidget(
                      //   menu_icon: const Icon(
                      //     Icons.currency_exchange,
                      //     color: colorWhite,
                      //   ),
                      //   menu_name: "Change Currency",
                      //   target_page: ChangeCurrencyScreen(
                      //     main_wallet_currency: main_wallet_currency,
                      //   ),
                      // ),
                      // const SizedBox(
                      //   width: 10,
                      // ),
                      MainMenuButtonWidget(
                        menu_icon: const Icon(
                          Icons.shopping_basket_rounded,
                          color: colorWhite,
                        ),
                        menu_name: AppLocalizations.of(context)!.shopping,
                        target_page:
                            const CategoryScreen(isMain: true), // ShoppingPage
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MainMenuButtonWidget(
                        menu_icon: const Icon(
                          FontAwesomeIcons.ticket,
                          color: colorWhite,
                        ),
                        menu_name: AppLocalizations.of(context)!.lucky_draw,
                        target_page: LuckyDrawPage(
                          currency: main_wallet_currency,
                        ),
                      ),
                      // Expanded(
                      //   child: AspectRatio(
                      //     aspectRatio: 1,
                      //     child: Container(),
                      //   ),
                      // ),
                      const SizedBox(
                        width: 10,
                      ),
                      MainMenuButtonWidget(
                        menu_icon: Icon(
                          Icons.topic,
                          color: colorWhite,
                        ),
                        menu_name: AppLocalizations.of(context)!.top_up,
                        target_page:  const TopUpScreen(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MainMenuButtonWidget(
                        menu_icon:  Icon(
                          Linecons.shop,
                          color: colorWhite,
                        ),
                        menu_name: "Money Market",
                        target_page: MoneyMarketScreen(),
                      ),
                      const SizedBox(width: 18,),
                      Expanded(
                        flex: 3,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
