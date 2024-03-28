import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../helpers/shared_pref.dart';
import '../../../l10n/l10n.dart';
import '../../../resources/colors.dart';
import '../../../view_models/app_language_view_model.dart';
import '../../../widgets/long_button_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseLanView extends StatefulWidget {
  const ChooseLanView({
    super.key,
  });

  @override
  State<ChooseLanView> createState() => _ChooseLanViewState();
}

class _ChooseLanViewState extends State<ChooseLanView> {


  late AppLanguageViewModel appLanguage;
  @override
  void initState() {
    getData();
    super.initState();
  }
  void getData() async {
    String? langCode = await SharedPref.getData(key: SharedPref.language_code);
    setState(() {
      selLanId = langCode == "en" ? 0 : 1;
    });
  }

  int? selLanId = 0;

  @override
  Widget build(BuildContext context) {
    appLanguage = Provider.of<AppLanguageViewModel>(context);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: MaterialButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30)),
            ),
            context: context,
            builder: (BuildContext bc) {
              return StatefulBuilder(
                  builder: (BuildContext context, setStateBTS) {
                    return Scrollbar(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 2.8,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 5,),
                              Center(
                                child: Container(
                                  decoration:const BoxDecoration(
                                      color: colorPrimary,
                                      borderRadius:
                                       BorderRadius.all(
                                          Radius.circular(15))),
                                  height: 4,
                                  width: 50,
                                ),
                              ),
                             const SizedBox(height: 20,),
                              Text(AppLocalizations.of(context)!.choose_language,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),),
                              Container(
                                height: 150,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20),
                                child: CupertinoPicker(
                                  itemExtent: 50,
                                  scrollController:
                                  FixedExtentScrollController(
                                      initialItem: selLanId!),
                                  children: List.generate(
                                      L10n.all.length,
                                          (item) => Center(
                                          child: Text(
                                            L10n.all[item].languageCode == 'en' ? "English" : "မြန်မာ",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: selLanId !=
                                                  null &&
                                                  selLanId ==
                                                      item
                                                  ? Colors.black
                                                  : Colors.grey,
                                          ),
                                          ))).toList(),
                                  onSelectedItemChanged: (value) {
                                    setState(() {
                                      selLanId = value;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: LongButtonView(
                                  text: AppLocalizations.of(context)!.save,
                                  onTap: () async {
                                    appLanguage.changeLanguage(Locale("${L10n.all[selLanId!]}"));
                                    SharedPref.setData(
                                      key: SharedPref.setLanId,
                                      value: selLanId.toString(),
                                    );
                                    Navigator.pop(context);
                                  }
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.language,
              size: 20,
              color: Colors.grey.shade600,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Language",
              style: TextStyle(
                color: Colors.grey.shade900,
              ),
            ),
            const Expanded(child: SizedBox()),

            Text(
              L10n.all[selLanId!].languageCode == 'en' ? "English" : "မြန်မာ",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              size: 18,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
}
