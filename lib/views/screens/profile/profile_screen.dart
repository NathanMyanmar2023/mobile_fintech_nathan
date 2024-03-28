import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nathan_app/helpers/shared_pref.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/screens/about_screen.dart';
import 'package:nathan_app/views/screens/main_screen.dart';
import 'package:nathan_app/views/screens/password/change_password_screen.dart';
import 'package:nathan_app/views/screens/rank/rank_screen.dart';
import 'package:nathan_app/views/screens/t_and_c_screen.dart';
import 'package:nathan_app/views/screens/welcome_screen.dart';
import 'package:nathan_app/views/widgets/profile_menu_widget.dart';
import 'package:nathan_app/widgets/long_button_view.dart';
import 'choose_lan_view.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  final String username;
  final String profile_picture;
  final String refer_code;

  final String phone;
  final String email;

  final String country;
  final String address_line;
  final String region;
  final String city;

  const ProfileScreen({
    super.key,
    required this.name,
    required this.username,
    required this.profile_picture,
    required this.refer_code,
    required this.phone,
    required this.email,
    required this.country,
    required this.address_line,
    required this.region,
    required this.city,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(
        "${widget.phone}/${widget.email}/${widget.country}/${widget.address_line}/${widget.region}/${widget.city}");
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: AppBar(
              toolbarHeight: 70,
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: colorPrimary),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                AppLocalizations.of(context)!.profile,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: colorPrimary,
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 15),
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: CachedNetworkImage(
                            imageUrl: widget.profile_picture,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 120.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(45),
                                image: DecorationImage(
                                  image: NetworkImage(widget.profile_picture),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 17,
                              color: colorPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.username,
                            style: const TextStyle(
                              fontSize: 12,
                              color: colorPrimary,
                            ),
                          ),
                        ],
                      ),
                      // const Expanded(
                      //   child: SizedBox(),
                      // ),
                      // const SizedBox(
                      //   width: 10,
                      // ),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.of(context)
                      //         .push(MaterialPageRoute(builder: (context) {
                      //       return EditProfileScreen(
                      //         current_name: widget.name,
                      //         current_profile_picture: widget.profile_picture,
                      //         current_email: widget.email,
                      //         current_address_line: widget.address_line,
                      //         current_region: widget.region,
                      //         current_city: widget.city,
                      //       );
                      //     }));
                      //   },
                      //   child: Icon(
                      //     Icons.edit_note_outlined,
                      //     size: 25,
                      //     color: Colors.grey.shade400,
                      //   ),
                      // ),
                      // const SizedBox(
                      //   width: 10,
                      // ),
                    ],
                  ),
                ),
                if (MainScreen.role == '1')
                  const SizedBox(
                    height: 20,
                  ),
                if (MainScreen.role == '1')
                  Container(
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                         Text(
                           AppLocalizations.of(context)!.refer_code,
                          style: const TextStyle(
                            fontSize: 14,
                            color: colorWhite,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Text(
                          widget.refer_code,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: colorWhite,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            await Clipboard.setData(
                              ClipboardData(text: widget.refer_code),
                            );
                            showSnack(
                              "${AppLocalizations.of(context)!.copied_refer_code} - ${widget.refer_code}",
                              Colors.white,
                              Colors.green,
                              Icons.copy_outlined,
                            );
                          },
                          child: const Icon(
                            Icons.copy_outlined,
                            size: 20,
                            color: colorWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (MainScreen.role == '1')
                  const SizedBox(
                    height: 20,
                  ),
                if (MainScreen.role == '1')
                   SizedBox(
                    width: double.infinity,
                    child: Text(
                      AppLocalizations.of(context)!.account_status,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                if (MainScreen.role == '1')
                  const SizedBox(
                    height: 10,
                  ),
                if (MainScreen.role == '1')
                  const SizedBox(
                    height: 10,
                  ),
                const ChooseLanView(),
                if (MainScreen.role == '1')
                   ProfileMenuWidget(
                    icon: Icons.leaderboard_outlined,
                    label: AppLocalizations.of(context)!.rank,
                    targe_page: RankScreen(),
                  ),
                const SizedBox(
                  height: 20,
                ),
                 SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)!.security_privacy,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                 ProfileMenuWidget(
                  icon: Icons.lock_outline,
                  label: AppLocalizations.of(context)!.change_password,
                  targe_page: const ChangePasswordScreen(),
                ),
                const SizedBox(
                  height: 10,
                ),
                 ProfileMenuWidget(
                  icon: Icons.privacy_tip_outlined,
                  label: AppLocalizations.of(context)!.terms_conditions,
                  targe_page: const TAndCScreen(),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)!.settings,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                 ProfileMenuWidget(
                  icon: Icons.info_outline,
                  label: AppLocalizations.of(context)!.about_application,
                  targe_page: const AboutScreen(),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                //  ProfileMenuWidget(
                //   icon: Icons.contact_page_outlined,
                //   label: AppLocalizations.of(context)!.contact_us,
                //   targe_page: const AboutScreen(),
                // ),
                const SizedBox(
                  height: 20,
                ),
                LongButtonView(
                  text: AppLocalizations.of(context)!.logout,
                  onTap: () => logout(),
                ),
                // MaterialButton(
                //   color: Colors.red,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(45),
                //   ),
                //   height: 45,
                //   elevation: 0,
                //   onPressed: logout,
                //   child: const SizedBox(
                //     height: 20,
                //     child: Center(
                //         child: Text(
                //       'Logout',
                //       style: TextStyle(
                //         color: Colors.white,
                //       ),
                //     )),
                //   ),
                // ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showSnack(String msg, Color msgColor, Color bgColor, IconData icon) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            msg,
            style: TextStyle(
              color: msgColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      shape: const StadiumBorder(),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      backgroundColor: bgColor,
      elevation: 0,
    ));
  }

  logout() {
    SharedPref.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) {
      return const WelcomeScreen();
    }), (route) => false);
  }
}
