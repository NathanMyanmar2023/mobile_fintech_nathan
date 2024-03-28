//
// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:nathan_app/extensions/navigation_extensions.dart';
// import 'package:nathan_app/itemviews/balance_option_item_view.dart';
// import 'package:nathan_app/itemviews/wallet_item_view.dart';
// import 'package:nathan_app/pages/investment_page.dart';
// import 'package:nathan_app/pages/lucky_draw_page.dart';
// import 'package:nathan_app/pages/wallet_exchange_page.dart';
// import 'package:nathan_app/pages/withdraw_page.dart';
// import 'package:provider/provider.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (BuildContext context) => HomeBloc(),
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Consumer(
//             builder: (BuildContext context, HomeBloc bloc, Widget? child) =>
//                 Column(
//               children: [
//                 WalletSectionView(
//                   onPageChange: (index) => bloc.onChangeActiveWallet(
//                     index: index,
//                   ),
//                   currentIndex: bloc.currentWalletIndex,
//                 ),
//                 const SizedBox(
//                   height: 48,
//                 ),
//                 const BalanceOptionSectionView(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class BalanceOptionSectionView extends StatelessWidget {
//   const BalanceOptionSectionView({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.symmetric(horizontal: 32),
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               BalanceOptionItemView(
//                 onTap: () => navigateToNextPage(
//                   context: context,
//                   nextPage: const DepositPage(),
//                 ),
//                 title: "Deposit",
//               ),
//               const SizedBox(
//                 width: 4,
//               ),
//               BalanceOptionItemView(
//                 onTap: () => navigateToNextPage(
//                   context: context,
//                   nextPage: const WalletExchangePage(),
//                 ),
//                 title: "Exchange",
//               ),
//               const SizedBox(
//                 width: 4,
//               ),
//               BalanceOptionItemView(
//                 onTap: () => navigateToNextPage(
//                   context: context,
//                   nextPage: const InvestmentPage(),
//                 ),
//                 title: "Investment",
//               ),
//               const SizedBox(
//                 width: 4,
//               ),
//               BalanceOptionItemView(
//                 onTap: () => navigateToNextPage(
//                   context: context,
//                   nextPage: const WithdrawPage(),
//                 ),
//                 title: "Withdraw",
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 42,
//           ),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               BalanceOptionItemView(
//                 onTap: () => navigateToNextPage(
//                   context: context,
//                   nextPage: const TransferPage(),
//                 ),
//                 title: "Transfer",
//               ),
//               const SizedBox(
//                 width: 4,
//               ),
//               BalanceOptionItemView(
//                 onTap: () => navigateToNextPage(
//                   context: context,
//                   nextPage: const ChangeCurrencyPage(),
//                 ),
//                 title: "Change\nCurrency",
//               ),
//               const SizedBox(
//                 width: 4,
//               ),
//               BalanceOptionItemView(
//                 onTap: () {},
//                 title: "Shopping",
//               ),
//               const SizedBox(
//                 width: 4,
//               ),
//               BalanceOptionItemView(
//                 onTap: () => navigateToNextPage(
//                   context: context,
//                   nextPage: const LuckyDrawPage(),
//                 ),
//                 title: "Lucky\nDraw",
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class WalletSectionView extends StatelessWidget {
//   final Function(int) onPageChange;
//   final int currentIndex;
//
//   const WalletSectionView({
//     super.key,
//     required this.onPageChange,
//     required this.currentIndex,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 160,
//           margin: const EdgeInsets.only(
//             top: 32,
//           ),
//           child: PageView.builder(
//             itemCount: 3,
//             scrollDirection: Axis.horizontal,
//             onPageChanged: (index) => onPageChange(index),
//             itemBuilder: (BuildContext context, int index) =>
//                 const WalletItemView(),
//           ),
//         ),
//         const SizedBox(
//           height: 8,
//         ),
//         DotsIndicator(
//           dotsCount: 3,
//           position: currentIndex,
//           decorator: const DotsDecorator(
//             spacing: EdgeInsets.only(
//               right: 4,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
