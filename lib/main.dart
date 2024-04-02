import 'package:flutter/material.dart';
import 'package:nathan_app/view_models/add_address_view_model.dart';
import 'package:nathan_app/view_models/cart_view_model.dart';
import 'package:nathan_app/view_models/app_language_view_model.dart';
import 'package:nathan_app/views/screens/login_screen.dart';
import 'package:nathan_app/views/screens/main_screen.dart';
import 'package:nathan_app/views/screens/register_screen.dart';
import 'package:nathan_app/views/screens/register_success_screen.dart';
import 'package:nathan_app/views/screens/splash_screen.dart';
import 'package:nathan_app/views/screens/welcome_screen.dart';
import 'package:nathan_app/view_models/product_view_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguageViewModel appLanguage = AppLanguageViewModel();
  await appLanguage.fetchLocale();
  runApp( Nathan(
    appLanguage: appLanguage,
  ));
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
            child: Consumer<AppLanguageViewModel>(
                builder: (context, model, child)  {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  themeMode: ThemeMode.light,
                  title: 'Fintech Nathan',
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
                    RegisterSuccessScreen.id: (context) => const RegisterSuccessScreen(),
                    MainScreen.id: (context) => const MainScreen(),
                  },
                );
              }
            ),
          ),
        );
      }
    );
  }
}
