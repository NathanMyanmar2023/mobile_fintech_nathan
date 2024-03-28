import 'package:flutter/material.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:provider/provider.dart';
import '../../helpers/shared_pref.dart';
import '../../l10n/l10n.dart';
import '../../view_models/app_language_view_model.dart';
import '../../view_models/radio_view_model.dart';
import '../../widgets/long_button_view.dart';
import 'main_screen.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({Key? key}) : super(key: key);

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  int? _selectedIndex = 0;
  late AppLanguageViewModel appLanguage;
  static final languageList = [
    const RadioViewModel(id: 0,name: "English", value: "en"),
    const RadioViewModel(id: 1, name: "မြန်မာ", value: "my"),
  ];
  @override
  Widget build(BuildContext context) {
    appLanguage = Provider.of<AppLanguageViewModel>(context);
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                width: 150,
                height: 150,
                child: Image.asset('assets/language.png'),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Choose your Language",
                style: TextStyle(
                  letterSpacing: 1,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Divider(height: 2,),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: ListView.builder(
                    itemCount: languageList.length,
                    itemBuilder: (context, index) {
                      return RadioListTile(
                        value: languageList[index].id,
                        groupValue: _selectedIndex,
                        onChanged: (value) {
                          setState(() {
                            _selectedIndex = value;
                          });
                        },
                        activeColor: colorPrimary,
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                languageList[index].value == 'en' ? 'assets/en_flag.png' : 'assets/my_flag.png',
                                width: 30, height: 30,fit: BoxFit.cover,),
                          ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(languageList[index].name),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LongButtonView(
                  text: 'Next',
                  onTap: () {
                    print("_sel ${languageList[_selectedIndex!].value}");
                    SharedPref.setData(
                      key: SharedPref.language_code,
                      value: languageList[_selectedIndex!].value,
                    );
                    appLanguage.changeLanguage(Locale("${L10n.all[languageList[_selectedIndex!].value == "en" ? 0 : 1]}"));
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return const MainScreen();
                    }));
                  },
                ),
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
