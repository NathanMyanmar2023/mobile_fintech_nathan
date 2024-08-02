import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:fnge/view_models/add_address_view_model.dart';
import 'package:fnge/view_models/cart_view_model.dart';
import 'package:fnge/view_models/app_language_view_model.dart';
import 'package:fnge/views/notification/notification_service.dart';
import 'package:fnge/views/screens/login_screen.dart';
import 'package:fnge/views/screens/main_screen.dart';
import 'package:fnge/views/screens/register_screen.dart';
import 'package:fnge/views/screens/register_success_screen.dart';
import 'package:fnge/views/screens/splash_screen.dart';
import 'package:fnge/views/screens/welcome_screen.dart';
import 'package:fnge/view_models/product_view_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String _deviceToken = '';

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDD4fyBjXnKohSDE2xDHLhePuelc6z_MX4",
            authDomain: "nathanfintech-c0270.firebaseapp.com",
            projectId: "nathanfintech-c0270",
            storageBucket: "nathanfintech-c0270.appspot.com",
            messagingSenderId: "314757345053",
            appId: "1:314757345053:web:2d8c07ac6df85572897bf4",
            measurementId: "G-K0W6XSDX8W"));
    // AdManagerWeb.init();
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _deviceToken = await _saveDeviceToken();
    await MobileAds.instance.initialize();
    // thing to add
    List<String> testDeviceIds = ["6CB9DF638CDF0411C30830373D9580A0"];
    RequestConfiguration configuration =
        RequestConfiguration(testDeviceIds: testDeviceIds);
    MobileAds.instance.updateRequestConfiguration(configuration);
  }

  AppLanguageViewModel appLanguage = AppLanguageViewModel();
  await appLanguage.fetchLocale();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(Nathan(
      appLanguage: appLanguage,
    ));
  });
}

Future<String> _saveDeviceToken() async {
  String _deviceToken = '';
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    String? deviceId = androidInfo.androidId; // Unique device ID for Android
    print('Device ID: $deviceId');
    _deviceToken = deviceId!;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    String? deviceId = iosInfo.identifierForVendor; // Unique device ID for iOS
    print('Device ID: $deviceId');
    _deviceToken = deviceId!;
  }
  if (_deviceToken != null) {
    print('--------Device Token---------- ' + _deviceToken);
  }
  return _deviceToken;
}

class Nathan extends StatelessWidget {
  AppLanguageViewModel? appLanguage;
  Nathan({super.key, required this.appLanguage});
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppLanguageViewModel()),
          ChangeNotifierProvider(create: (context) => ProductViewModel()),
          ChangeNotifierProvider(create: (context) => CartViewModel()),
          ChangeNotifierProvider(create: (context) => AddAddressViewModel()),
        ],
        child: ChangeNotifierProvider(
          create: (BuildContext context) => appLanguage,
          child:
              Consumer<AppLanguageViewModel>(builder: (context, model, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.light,
              title: 'FNGC',
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              locale: model.appLocal,
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('my', 'MY'),
              ],
              initialRoute: SplashScreen.id,
              routes: {
                SplashScreen.id: (context) => const SplashScreen(),
                WelcomeScreen.id: (context) => const WelcomeScreen(),
                RegisterScreen.id: (context) => const RegisterScreen(),
                LoginScreen.id: (context) => const LoginScreen(),
                RegisterSuccessScreen.id: (context) =>
                    const RegisterSuccessScreen(),
                MainScreen.id: (context) => const MainScreen(),
              },
            );
          }),
        ),
      );
    });
  }
}
