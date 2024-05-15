import 'package:flutter/material.dart';
import 'package:flutter_app_version_checker/flutter_app_version_checker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nathan_app/bloc/user_info_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/navigation_utils.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/pages/history_page.dart';
import 'package:nathan_app/views/pages/home_page.dart';
import 'package:nathan_app/views/pages/network_page.dart';
import 'package:nathan_app/views/screens/profile/profile_screen.dart';
import 'package:nathan_app/views/screens/welcome_screen.dart';
import 'package:nathan_app/views/widgets/error_alert_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../helpers/shared_pref.dart';
import '../../widgets/nathan_text_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static String id = 'main_screen';
  static String role = '1';
  static String is_kyc = '0';
  static String kyc_message = '';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = true;

  late PageController _main_page_controller;

  final _user_info_bloc = UserInfoBloc();
  late Stream<ResponseOb> _user_info_stream;

  //USER INFOs
  int accountId = 0;
  String name = "";
  String username = "";
  String profile_picture = "";
  String refer_code = "";

  String phone = "";
  String email = "";

  String country = "";
  String address_line = "";
  String region = "";
  String city = "";

  //USER INFOs END

  //Pages on Main Screen
  final network_pages = const [
    HomePage(),
    NetworkPage(),
    // CategoryScreen(),
    HistoryPage(),
  ];

  final customer_pages = const [
    HomePage(),
    //CategoryScreen(),
    HistoryPage(),
  ];

  final _checker = AppVersionChecker();
  String? version;
  String APP_STORE_URL = "https://apps.apple.com/mm/app/1664gym/id1664655431";
  String PLAY_STORE_URL =
      "https://play.google.com/store/apps/details?id=com.fintech.app.nathan";

  void checkPlayStoreVersion(bool change) async {
    _checker.checkUpdate().then((value) async {
      print(
          "newVersion ${value.newVersion}"); //return error message if found else it will return null
      setState(() {
        version = value.currentVersion;
      });
      if (value.canUpdate == true) {
        String message =
            "Please update to countiue using the app.\n We have launched new feature.";
        String btnLabel = "Update Now";
        String btnLabelCancel = "Later";
        showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Center(
                  child: Text(
                "App Update Required!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: colorPrimary,
                ),
              )),
              // content:  AlertVersionInfoView(),
              content: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                // margin: const EdgeInsets.only(top: 10),
                height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NathanTextView(
                      text: message,
                      fontSize: 14,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () =>
                              change ? goBack() : Navigator.pop(context),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                          ),
                          child: Text(btnLabelCancel),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          child: Text(
                            btnLabel,
                            style: TextStyle(color: colorWhite),
                          ),
                          onPressed: () => _launchURL(PLAY_STORE_URL),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: colorPrimary),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              backgroundColor: colorWhite,
              contentPadding: EdgeInsets.zero,
              titlePadding: const EdgeInsets.only(top: 15),
              surfaceTintColor: Colors.transparent,
            );
          },
        );
      } else {
        print("Noo need update");
      }
    });
  }

  void goBack() {
    Navigator.pop(context);
    Navigator.pop(context);
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  int _current_page_index = 0;

  @override
  void initState() {
    checkPlayStoreVersion(false);
    // TODO: implement initState
    super.initState();
    _main_page_controller = PageController();

    //USER INFO
    _user_info_stream = _user_info_bloc.userInfoStream();
    _user_info_stream.listen((ResponseOb resp) {
      if (resp.authorized == false) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) {
          return const WelcomeScreen();
        }), (route) => false);
        return;
      }
      if (resp.success) {
        setState(() {
          MainScreen.role = resp.data.data.role;
          MainScreen.is_kyc = resp.data.data.isKyc;
          MainScreen.kyc_message = resp.data.data.kyc_message;
          name = resp.data.data.name;
          username = resp.data.data.username;
          profile_picture = resp.data.data.image;
          refer_code = resp.data.data.referCode;

          phone = resp.data.data.phone;
          email = resp.data.data.email;

          country = resp.data.data.country;
          address_line = resp.data.data.addressLine;
          region = resp.data.data.region;
          city = resp.data.data.city;
          print("pho $phone");
          accountId = resp.data.data.id;
          print("accountInfoId $accountId");
          print("profile_picture ${profile_picture}");
          SharedPref.setData(
            key: SharedPref.accountId,
            value: "$accountId",
          );
        });
        setState(() {
          isLoading = false;
        });
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

    _user_info_bloc.getUserInfos();
  }

  void onPageChange(int index) {
    checkPlayStoreVersion(true);
    setState(() {
      _current_page_index = index;
    });
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
      return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            toolbarHeight: 70,
            backgroundColor: Colors.transparent,
            elevation: 0,
            titleSpacing: 0,
            leading: MaterialButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ProfileScreen(
                    username: username,
                    name: name,
                    profile_picture: profile_picture,
                    refer_code: refer_code,
                    phone: phone,
                    email: email,
                    country: country,
                    address_line: address_line,
                    region: region,
                    city: city,
                  );
                }));
              },
              child: const Icon(
                Icons.person_rounded,
                color: colorPrimary,
              ),
            ),
            title: InkWell(
              onTap: () {
                //Search
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      AppLocalizations.of(context)!.search,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              MaterialButton(
                minWidth: 30,
                onPressed: () {
                  openOrder(context);
                },
                child: const Icon(
                  FontAwesomeIcons.list,
                  size: 20,
                  color: colorPrimary,
                ),
              ),
              MaterialButton(
                minWidth: 30,
                onPressed: () {
                  openCart(context);
                },
                child: const Icon(
                  FontAwesomeIcons.cartShopping,
                  size: 20,
                  color: colorPrimary,
                ),
              ),
            ],
          ),
        ),
        body: PageView(
          controller: _main_page_controller,
          onPageChanged: onPageChange,
          children: MainScreen.role == '1' ? network_pages : customer_pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: MainScreen.role == "1"
              ? <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    label: AppLocalizations.of(context)!.home,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.account_tree_outlined),
                    label: AppLocalizations.of(context)!.network,
                  ),
                  // BottomNavigationBarItem(
                  //   icon: const Icon(Linecons.shop),
                  //   label: AppLocalizations.of(context)!.shop,
                  // ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.history),
                    label: AppLocalizations.of(context)!.history,
                  ),
                ]
              : <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    label: AppLocalizations.of(context)!.home,
                  ),
                  // BottomNavigationBarItem(
                  //   icon: const Icon(Linecons.shop),
                  //   label: AppLocalizations.of(context)!.shop,
                  // ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.history),
                    label: AppLocalizations.of(context)!.history,
                  ),
                ],
          showUnselectedLabels: true,
          currentIndex: _current_page_index,
          selectedItemColor: colorPrimary,
          unselectedItemColor: Colors.grey.shade500,
          onTap: (index) => {
            onPageChange(index),
            _main_page_controller.jumpToPage(_current_page_index),
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _main_page_controller.dispose();
    super.dispose();
  }
}
