import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:nathan_app/bloc/network/levels_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/views/widgets/level_selector_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({super.key});

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool isLoading = false;
  int level_one_count = 0;
  int level_two_count = 0;
  int level_three_count = 0;
  int level_four_count = 0;
  int level_five_count = 0;
  int level_six_count = 0;
  int level_seven_count = 0;
  int level_eight_count = 0;
  int level_nine_count = 0;
  int level_ten_count = 0;

  int level_one_amount = 0;
  int level_two_amount = 0;
  int level_three_amount = 0;
  int level_four_amount = 0;
  int level_five_amount = 0;
  int level_six_amount = 0;
  int level_seven_amount = 0;
  int level_eight_amount = 0;
  int level_nine_amount = 0;
  int level_ten_amount = 0;

  final _levels_bloc = LevelsBloc();
  late Stream<ResponseOb> _levels_stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _levels_stream = _levels_bloc.levelsStream();
    _levels_stream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          level_one_count = resp.data.data.levelOne.persons;
          level_two_count = resp.data.data.levelTwo.persons;
          level_three_count = resp.data.data.levelThree.persons;
          level_four_count = resp.data.data.levelFour.persons;
          level_five_count = resp.data.data.levelFive.persons;
          level_six_count = resp.data.data.levelSix.persons;
          level_seven_count = resp.data.data.levelSeven.persons;
          level_eight_count = resp.data.data.levelEight.persons;
          level_nine_count = resp.data.data.levelNine.persons;
          level_ten_count = resp.data.data.levelTen.persons;

          level_one_amount = resp.data.data.levelOne.investTotal;
          level_two_amount = resp.data.data.levelTwo.investTotal;
          level_three_amount = resp.data.data.levelThree.investTotal;
          level_four_amount = resp.data.data.levelFour.investTotal;
          level_five_amount = resp.data.data.levelFive.investTotal;
          level_six_amount = resp.data.data.levelSix.investTotal;
          level_seven_amount = resp.data.data.levelSeven.investTotal;
          level_eight_amount = resp.data.data.levelEight.investTotal;
          level_nine_amount = resp.data.data.levelNine.investTotal;
          level_ten_amount = resp.data.data.levelTen.investTotal;
          isLoading = false;
        });
      } else {
        isLoading = false;
        print("ERROR");
      }
    });

    _levels_bloc.getLevels();
  }

  Future refersh() async {
    _levels_bloc.getLevels();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (isLoading) {
      return Scaffold(
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
      );
    } else {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: RefreshIndicator(
            onRefresh: refersh,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (level_one_count +
                                                level_two_count +
                                                level_three_count +
                                                level_four_count +
                                                level_five_count)
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                       Row(
                                        children: [
                                         const Icon(
                                            FontAwesome.user,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 5),
                                          Flexible(
                                            child: Text(
                                              AppLocalizations.of(context)!.total_users,
                                              maxLines: 2,
                                              softWrap: true,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (level_one_amount +
                                                level_two_amount +
                                                level_three_amount +
                                                level_four_amount +
                                                level_five_amount)
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                       Row(
                                        children: [
                                          Icon(
                                            FontAwesome.bank,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            AppLocalizations.of(context)!.investment,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        LevelSelectorWidget(
                          level: 1,
                          level_text: AppLocalizations.of(context)!.one,
                          user_count: level_one_count.toString(),
                          investment_amount: level_one_amount.toString(),
                        ),
                        const SizedBox(height: 15),
                        LevelSelectorWidget(
                          level: 2,
                          level_text: AppLocalizations.of(context)!.two,
                          user_count: level_two_count.toString(),
                          investment_amount: level_two_amount.toString(),
                        ),
                        const SizedBox(height: 15),
                        LevelSelectorWidget(
                          level: 3,
                          level_text: AppLocalizations.of(context)!.three,
                          user_count: level_three_count.toString(),
                          investment_amount: level_three_amount.toString(),
                        ),
                        const SizedBox(height: 15),
                        LevelSelectorWidget(
                          level: 4,
                          level_text: AppLocalizations.of(context)!.four,
                          user_count: level_four_count.toString(),
                          investment_amount: level_four_amount.toString(),
                        ),
                        const SizedBox(height: 15),
                        LevelSelectorWidget(
                          level: 5,
                          level_text: AppLocalizations.of(context)!.five,
                          user_count: level_five_count.toString(),
                          investment_amount: level_five_amount.toString(),
                        ),
                        const SizedBox(height: 15),
                        LevelSelectorWidget(
                          level: 6,
                          level_text: AppLocalizations.of(context)!.six,
                          user_count: level_six_count.toString(),
                          investment_amount: level_six_amount.toString(),
                        ),
                        const SizedBox(height: 15),
                        LevelSelectorWidget(
                          level: 7,
                          level_text: AppLocalizations.of(context)!.seven,
                          user_count: level_seven_count.toString(),
                          investment_amount: level_seven_amount.toString(),
                        ),
                        const SizedBox(height: 15),
                        LevelSelectorWidget(
                          level: 8,
                          level_text: AppLocalizations.of(context)!.eight,
                          user_count: level_eight_count.toString(),
                          investment_amount: level_eight_amount.toString(),
                        ),
                        const SizedBox(height: 15),
                        LevelSelectorWidget(
                          level: 9,
                          level_text: AppLocalizations.of(context)!.nine,
                          user_count: level_nine_count.toString(),
                          investment_amount: level_nine_amount.toString(),
                        ),
                        const SizedBox(height: 15),
                        LevelSelectorWidget(
                          level: 10,
                          level_text: AppLocalizations.of(context)!.ten,
                          user_count: level_ten_count.toString(),
                          investment_amount: level_ten_amount.toString(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
