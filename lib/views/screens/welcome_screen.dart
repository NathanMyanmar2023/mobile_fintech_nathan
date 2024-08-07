import 'package:flutter/material.dart';
import 'package:fnge/extensions/navigation_extensions.dart';
import 'package:fnge/resources/colors.dart';
import 'package:fnge/resources/constants.dart';
import 'package:fnge/views/screens/login_screen.dart';
import 'package:fnge/views/screens/register_screen.dart';
import 'package:fnge/widgets/auth_title_and_description_section_view.dart';
import 'package:fnge/widgets/long_button_view.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [topColor, bottomColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 9,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AuthTitleAndDescriptionSectionView(
                      title: "START GROW YOUR MONEY",
                      description: "INVEST AND GROW MONEY WITH FNGC",
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(25),
                      child: Image.asset(
                        appLogo,
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                decoration: const BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LongButtonView(
                      text: 'LOGIN',
                      onTap: () => navigateToNextPage(
                        context: context,
                        nextPage: const LoginScreen(),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    LongButtonView(
                      text: 'CREATE ACCOUNT',
                      onTap: () => navigateToNextPage(
                        context: context,
                        nextPage: const RegisterScreen(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
