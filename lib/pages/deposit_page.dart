// import 'package:flutter/material.dart';
// import 'package:nathan_app/itemviews/wallet_item_view.dart';
// import 'package:nathan_app/resources/colors.dart';
// import 'package:nathan_app/resources/constants.dart';
// import 'package:nathan_app/widgets/long_button_view.dart';
// import 'package:nathan_app/widgets/text_field_with_label_view.dart';
// import 'package:provider/provider.dart';
//
// class DepositPage extends StatelessWidget {
//   const DepositPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (BuildContext context) => DepositBloc(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             "Deposit",
//             style: TextStyle(
//               color: colorPrimary,
//             ),
//           ),
//         ),
//         body: Consumer(
//           builder: (BuildContext context, DepositBloc bloc, Widget? child) =>
//               bloc.depositState == DepositState.chooseBank
//                   ? ChooseDepositBankSectionView(
//                       onTap: () => bloc.onChangeDepositState(isNextStep: true),
//                     )
//                   : Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 32),
//                       child: SingleChildScrollView(
//                         padding: const EdgeInsets.symmetric(vertical: 32),
//                         child: Column(
//                           children: [
//                             Image.asset(
//                               appLogo,
//                               width: 100,
//                               height: 100,
//                             ),
//                             SizedBox(
//                               height: MediaQuery.of(context).size.height * 0.02,
//                             ),
//                             const Text(
//                               "Withdraw with AYA Bank",
//                               style: TextStyle(
//                                 color: colorPrimary,
//                                 fontWeight: FontWeight.w800,
//                                 fontSize: 16,
//                               ),
//                             ),
//                             SizedBox(
//                               height: MediaQuery.of(context).size.height * 0.01,
//                             ),
//                             Text(
//                               "Provide your AYA Bank username and account number correctly",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: colorPrimary.withOpacity(0.5),
//                                 fontSize: 14,
//                               ),
//                             ),
//                             SizedBox(
//                               height: MediaQuery.of(context).size.height * 0.03,
//                             ),
//                             const WalletItemView(
//                               margin: EdgeInsets.zero,
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 20,
//                               ),
//                             ),
//                             SizedBox(
//                               height: MediaQuery.of(context).size.height * 0.03,
//                             ),
//                             TextFieldWithLabelView(
//                               label: "Amount(MMK)",
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               onChange: (value) {},
//                             ),
//                             SizedBox(
//                               height: MediaQuery.of(context).size.height * 0.04,
//                             ),
//                             TextFieldWithLabelView(
//                               label: "Account Name)",
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               onChange: (value) {},
//                             ),
//                             SizedBox(
//                               height: MediaQuery.of(context).size.height * 0.04,
//                             ),
//                             TextFieldWithLabelView(
//                               label: "Account Number",
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               onChange: (value) {},
//                             ),
//                             SizedBox(
//                               height: MediaQuery.of(context).size.height * 0.04,
//                             ),
//                             LongButtonView(
//                               text: "Next",
//                               onTap: () =>
//                                   bloc.onChangeDepositState(isNextStep: true),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//         ),
//       ),
//     );
//   }
// }
//
// class ChooseDepositBankSectionView extends StatelessWidget {
//   final Function onTap;
//
//   const ChooseDepositBankSectionView({
//     super.key,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//           horizontal: MediaQuery.of(context).size.width * 0.035),
//       child: GridView.builder(
//         padding: EdgeInsets.symmetric(
//             vertical: MediaQuery.of(context).size.width * 0.035),
//         itemCount: 4,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           mainAxisSpacing: MediaQuery.of(context).size.width * 0.05,
//           crossAxisSpacing: MediaQuery.of(context).size.width * 0.05,
//           mainAxisExtent: MediaQuery.of(context).size.height * 0.16,
//         ),
//         itemBuilder: (BuildContext context, int index) => DepositBankItemView(
//           onTap: () => onTap(),
//         ),
//       ),
//     );
//   }
// }
//
// class DepositBankItemView extends StatelessWidget {
//   final Function onTap;
//
//   const DepositBankItemView({
//     super.key,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => onTap(),
//       child: Container(
//         decoration: BoxDecoration(
//           color: colorGrey.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(
//             12,
//           ),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
//         child: Column(
//           children: [
//             Image.asset(
//               appLogo,
//               width: MediaQuery.of(context).size.width * 0.15,
//               height: MediaQuery.of(context).size.width * 0.15,
//             ),
//             const SizedBox(
//               height: 12,
//             ),
//             const Text(
//               "KBZ Banking",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontWeight: FontWeight.w800,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
