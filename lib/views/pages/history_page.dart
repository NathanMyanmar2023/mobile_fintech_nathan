import 'package:flutter/material.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:nathan_app/views/screens/history/application_fees_history_screen.dart';
import 'package:nathan_app/views/screens/history/deposit_history/deposit_history_screen.dart';
import 'package:nathan_app/views/screens/history/exchange_history/exchange_history_screen.dart';
import 'package:nathan_app/views/screens/history/invest_profit_history/invest_profit_history_screen.dart';
import 'package:nathan_app/views/screens/history/investment_history/investment_history_screen.dart';
import 'package:nathan_app/views/screens/history/network_profit_history/network_profit_history_screen.dart';
import 'package:nathan_app/views/screens/history/phone_bill_history/phone_bill_history_screen.dart';
import 'package:nathan_app/views/screens/history/referral_incentive_history/referral_incentive_history_screen.dart';
import 'package:nathan_app/views/screens/history/return_money_history/return_money_history_screen.dart';
import 'package:nathan_app/views/screens/history/transfer_history/transfer_history_screen.dart';
import 'package:nathan_app/views/screens/history/withdraw_history/withdraw_history_screen.dart';
import 'package:nathan_app/views/screens/main_screen.dart';
import 'package:nathan_app/views/widgets/select_history_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../screens/history/promotion_history/promotion_history_screen.dart';
import '../screens/history/shopping_network_history/shopping_network_history_screen.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SelectHistoryWidget(
                target_page: const DepositHistoryScreen(),
                history_name: AppLocalizations.of(context)!.deposit_history,
                history_icon: Linecons.wallet,
              ),
              SelectHistoryWidget(
                target_page: const ExchangeHistoryScreen(),
                history_name: AppLocalizations.of(context)!.exchange_history,
                history_icon: Iconic.exchange,
              ),
              SelectHistoryWidget(
                target_page: const WithdrawHistoryScreen(),
                history_name: AppLocalizations.of(context)!.withdraw_history,
                history_icon: Linecons.money,
              ),
              SelectHistoryWidget(
                target_page: const TransferHistoryScreen(),
                history_name: AppLocalizations.of(context)!.transfer_history,
                history_icon: Icons.send,
              ),
              SelectHistoryWidget(
                target_page: const InvestmentHistoryScreen(),
                history_name: AppLocalizations.of(context)!.investment_history,
                history_icon: Icons.account_balance_outlined,
              ),
              SelectHistoryWidget(
                target_page: const PromotionHistoryScreen(),
                history_name: AppLocalizations.of(context)!.promotion_history,
                history_icon: Icons.discount,
              ),
              const SizedBox(
                width: 10,
              ),
              SelectHistoryWidget(
                target_page: const InvestProfitHistoryScreen(),
                history_name: AppLocalizations.of(context)!.profit_history,
                history_icon: Icons.attach_money_sharp,
              ),
              const SizedBox(
                width: 10,
              ),
              SelectHistoryWidget(
                target_page: const ReturnMoneyHistoryScreen(),
                history_name: AppLocalizations.of(context)!.return_money_history,
                history_icon: Icons.account_balance_wallet_outlined,
              ),
              SelectHistoryWidget(
                target_page: const ApplicationFeesHistoryScreen(),
                history_name: AppLocalizations.of(context)!.application_fees_history,
                history_icon: Icons.feed_outlined,
              ),
              SelectHistoryWidget(
                target_page: const PhoneBillHistoryScreen(),
                history_name: AppLocalizations.of(context)!.phone_bill_history,
                history_icon: Icons.topic,
              ),
              const SizedBox(
                width: 10,
              ),
              if (MainScreen.role == "1") SelectHistoryWidget(
                target_page: const NetworkProfitHistoryScreen(),
                history_name: AppLocalizations.of(context)!.network_profit_history,
                history_icon: Icons.account_tree_outlined,
              ),
              if (MainScreen.role == "1") SelectHistoryWidget(
                target_page: const ShoppingNetworkHistoryScreen(),
                history_name: AppLocalizations.of(context)!.shopping_network_history,
                history_icon: Icons.shopping_basket_sharp,
              ),
              if (MainScreen.role == "1") SelectHistoryWidget(
                      target_page: const ReferralIncentiveHistoryScreen(),
                      history_name: AppLocalizations.of(context)!.referral_incentive_history,
                      history_icon: Icons.dataset_linked_outlined,
              ),
              // MainScreen.role == "1"
              //     ? const SelectHistoryWidget(
              //         target_page: InvestProfitHistoryScreen(),
              //         history_name: "Invest Profit History",
              //         history_icon: Icons.attach_money_sharp,
              //       )
              //     : const SelectHistoryWidget(
              //         target_page: HomePage(),
              //         history_name: "Return Money History",
              //         history_icon: Icons.account_balance_wallet_outlined,
              //       ),
              // if (MainScreen.role == "1")
              //   const Column(
              //     children: [
              //       SelectHistoryWidget(
              //         target_page: ReferralIncentiveHistoryScreen(),
              //         history_name: "Referral Incentive History",
              //         history_icon: Icons.dataset_linked_outlined,
              //       ),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       SelectHistoryWidget(
              //         target_page: NetworkProfitHistoryScreen(),
              //         history_name: "Network Profit History",
              //         history_icon: Icons.account_tree_outlined,
              //       ),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       SelectHistoryWidget(
              //         target_page: ReturnMoneyHistoryScreen(),
              //         history_name: "Money Return History",
              //         history_icon: Icons.account_balance_wallet_outlined,
              //       ),
              //     ],
              //   ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
