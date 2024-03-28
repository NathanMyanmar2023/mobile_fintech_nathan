// import 'package:flutter/material.dart';
// import 'package:nathan_app/extensions/navigation_extensions.dart';
// import 'package:nathan_app/pages/profile_page.dart';
// import 'package:provider/provider.dart';
//
// class IndexPage extends StatelessWidget {
//   const IndexPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (BuildContext context) => IndexBloc(),
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: Row(
//             children: [
//               GestureDetector(
//                 onTap: () => navigateToNextPage(
//                   context: context,
//                   nextPage: const ProfilePage(),
//                 ),
//                 child: const Icon(Icons.person),
//               ),
//               const SizedBox(width: 8.0),
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.0),
//                     border: Border.all(),
//                   ),
//                   child: const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 8.0),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         border: InputBorder
//                             .none, // Remove TextField's internal border
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8.0),
//               // Add some spacing between TextField and icon
//               const Icon(Icons.shopping_cart_rounded),
//               // Icon on the right
//             ],
//           ),
//         ),
//         body: SafeArea(
//           child: Consumer(
//             builder: (BuildContext context, IndexBloc bloc, Widget? child) => [
//               const HomePage(),
//               const ShopPage(),
//               const HistoryPage(),
//             ][bloc.currentIndex],
//           ),
//         ),
//         bottomNavigationBar: Consumer(
//           builder: (BuildContext context, IndexBloc bloc, Widget? child) =>
//               BottomNavigationBar(
//             currentIndex: bloc.currentIndex,
//             onTap: (index) => bloc.onChangeIndex(index: index),
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home_rounded),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.shopping_cart_rounded),
//                 label: 'Shop',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.history_rounded),
//                 label: 'History',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
