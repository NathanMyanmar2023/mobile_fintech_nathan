// import 'package:flutter/material.dart';
// import 'package:fnge/bloc/profile/profile_bloc.dart';
// import 'package:fnge/extensions/navigation_extensions.dart';
// import 'package:fnge/pages/change_password_page.dart';
// import 'package:fnge/resources/colors.dart';
// import 'package:fnge/resources/constants.dart';
// import 'package:fnge/widgets/long_button_view.dart';
// import 'package:provider/provider.dart';
//
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Profile"),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(32),
//         child: Consumer(
//           builder: (BuildContext context, ProfileBloc bloc, Widget? child) =>
//               Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image.asset(
//                 appLogo,
//                 width: 70,
//                 height: 70,
//               ),
//               const SizedBox(
//                 height: 32,
//               ),
//               const ProfileLabelTextView(
//                 label: "Security and Privacy",
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               SettingView(
//                 label: "Change Password",
//                 icon: Icons.lock_rounded,
//                 onTap: () => navigateToNextPage(
//                   context: context,
//                   nextPage: const ChangePasswordPage(),
//                 ),
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               SettingView(
//                 label: "Terms and conditions",
//                 icon: Icons.security_rounded,
//                 onTap: () {},
//               ),
//               const SizedBox(
//                 height: 42,
//               ),
//               const ProfileLabelTextView(
//                 label: "Setting",
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               SettingView(
//                 label: "Change Password",
//                 icon: Icons.lock_rounded,
//                 onTap: () {},
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               SettingView(
//                 label: "Contact us",
//                 icon: Icons.phone_android_rounded,
//                 onTap: () {},
//               ),
//               const SizedBox(
//                 height: 32,
//               ),
//               LongButtonView(
//                 text: "Logout",
//                 onTap: () => bloc.onTapLogout()?.then(
//                       (value) => moveToNextPage(
//                         context: context,
//                         nextPage: const AuthPage(),
//                       ),
//                     ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class SettingView extends StatelessWidget {
//   final IconData icon;
//   final Function onTap;
//   final String label;
//
//   const SettingView({
//     super.key,
//     required this.icon,
//     required this.onTap,
//     required this.label,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => onTap(),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 icon,
//                 color: colorGrey,
//               ),
//               const SizedBox(
//                 width: 8,
//               ),
//               Text(
//                 label,
//                 style: const TextStyle(
//                   color: colorGrey,
//                 ),
//               ),
//             ],
//           ),
//           const Icon(
//             Icons.arrow_forward_ios_rounded,
//             color: colorGrey,
//             size: 18,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ProfileLabelTextView extends StatelessWidget {
//   final String label;
//
//   const ProfileLabelTextView({
//     super.key,
//     required this.label,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       label,
//       style: const TextStyle(
//         fontWeight: FontWeight.w800,
//         fontSize: 18,
//       ),
//     );
//   }
// }
