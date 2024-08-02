import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fnge/bloc/rank/rank_bloc.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RankScreen extends StatefulWidget {
  const RankScreen({super.key});

  @override
  State<RankScreen> createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool isLoading = true;

  int is_ic = 0;
  int is_supervisor = 0;
  int is_manager = 0;
  int is_general_manager = 0;
  int is_director = 0;
  int is_president = 0;

  int total_ic = 0;
  int total_sup = 0;
  int total_mana = 0;
  int total_gm = 0;
  int total_dir = 0;
  int total_pres = 0;

  bool is_bonus_ic = false;
  bool is_bonus_sup = false;
  bool is_bonus_mana = false;
  bool is_bonus_gm = false;
  bool is_bonus_dir = false;
  bool is_bonus_pres = false;

  final _rank_bloc = RankBloc();
  late Stream<ResponseOb> _rank_stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _rank_stream = _rank_bloc.rankStream();
    _rank_stream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          is_ic = resp.data.data.iC.is_ic;
          is_supervisor = resp.data.data.supervisor.is_supervisor;
          is_manager = resp.data.data.manager.is_manager;
          is_general_manager = resp.data.data.generalManager.is_general_manager;
          is_director = resp.data.data.director.is_director;
          is_president = resp.data.data.president.is_president;

          total_ic = resp.data.data.iC.total_child;
          total_sup = resp.data.data.supervisor.total_child;
          total_mana = resp.data.data.manager.total_child;
          total_gm = resp.data.data.generalManager.total_child;
          total_dir = resp.data.data.director.total_child;
          total_pres = resp.data.data.president.total_child;

          is_bonus_ic = resp.data.data.iC.is_gave_bonus;
          is_bonus_sup = resp.data.data.supervisor.is_gave_bonus;
          is_bonus_mana = resp.data.data.manager.is_gave_bonus;
          is_bonus_gm = resp.data.data.generalManager.is_gave_bonus;
          is_bonus_dir = resp.data.data.director.is_gave_bonus;
          is_bonus_pres = resp.data.data.president.is_gave_bonus;

          isLoading = false;
        });
      } else {
        isLoading = false;
        print("ERROR");
      }
    });
    _rank_bloc.getRank();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (isLoading) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          body: Container(
            child: SpinKitFadingFour(
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
        ),
      );
    } else {
      return Scaffold(
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
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                AppLocalizations.of(context)!.rank,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.rank_rewards,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                RankWidget(
                  count: total_ic,
                  target_count: 8,
                  percent: total_ic / 8,
                  message:
                      "Invest amount 5,000USD of 8 persons to direct referral",
                  title: AppLocalizations.of(context)!.ic,
                  reward_amount: "1,500",
                  icon: Icons.account_tree_outlined,
                  icon_name: 'ic_rank.png',
                  color: Colors.green,
                  bg_color: Colors.green.shade50,
                  bonus: is_bonus_ic,
                ),
                const SizedBox(
                  height: 20,
                ),
                RankWidget(
                  count: total_sup,
                  target_count: 8,
                  percent: total_sup / 8,
                  message: "8 persons of IC rank to direct referral",
                  title: AppLocalizations.of(context)!.supervisor,
                  reward_amount: "6,000",
                  icon: Icons.supervisor_account_rounded,
                  icon_name: 'supervisor_rank.png',
                  color: Colors.green,
                  bg_color: Colors.green.shade50,
                  bonus: is_bonus_sup,
                ),
                const SizedBox(
                  height: 20,
                ),
                RankWidget(
                  count: total_mana,
                  target_count: 8,
                  percent: total_mana / 8,
                  message: "8 persons of Supervisor rank to direct referral",
                  title: AppLocalizations.of(context)!.manager,
                  reward_amount: "13,000",
                  icon: Icons.manage_accounts_outlined,
                  icon_name: 'manager_rank.png',
                  color: Colors.green,
                  bg_color: Colors.green.shade50,
                  bonus: is_bonus_mana,
                ),
                const SizedBox(
                  height: 20,
                ),
                RankWidget(
                  count: total_gm,
                  target_count: 8,
                  percent: total_gm / 8,
                  message: "8 persons of Manager rank to direct referral",
                  title: AppLocalizations.of(context)!.general_manager,
                  reward_amount: "57,000",
                  icon: Icons.groups,
                  icon_name: 'general_manager_rank.png',
                  color: Colors.green,
                  bg_color: Colors.green.shade50,
                  bonus: is_bonus_gm,
                ),
                const SizedBox(
                  height: 20,
                ),
                RankWidget(
                  count: total_dir,
                  target_count: 8,
                  percent: total_dir / 8,
                  message: "8 persons of GM rank to direct referral",
                  title: AppLocalizations.of(context)!.director,
                  reward_amount: "120,000",
                  icon: Icons.supervised_user_circle_outlined,
                  icon_name: 'director_rank.png',
                  color: Colors.green,
                  bg_color: Colors.green.shade50,
                  bonus: is_bonus_dir,
                ),
                const SizedBox(
                  height: 20,
                ),
                RankWidget(
                  count: total_pres,
                  target_count: 8,
                  percent: total_pres / 8,
                  message: "7 persons of Director rank to direct referral",
                  title: AppLocalizations.of(context)!.president,
                  reward_amount: "550,000",
                  icon: Icons.supervised_user_circle_outlined,
                  icon_name: 'owner_rank.png',
                  color: Colors.green,
                  bg_color: Colors.green.shade50,
                  bonus: is_bonus_pres,
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
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

class RankWidget extends StatelessWidget {
  const RankWidget({
    super.key,
    required this.count,
    required this.target_count,
    required this.percent,
    required this.message,
    required this.title,
    required this.reward_amount,
    required this.icon,
    required this.icon_name,
    required this.color,
    required this.bg_color,
    required this.bonus,
  });
  final int count;
  final int target_count;
  final double percent;
  final String message;
  final String title;
  final String reward_amount;
  final IconData icon;
  final String icon_name;
  final Color color;
  final Color bg_color;
  final bool bonus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: Image.asset(
                  'images/$icon_name',
                  // color: Colors.grey.shade300,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: bonus ? 90 : 80,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: bonus
                                    ? Colors.green.withOpacity(0.8)
                                    : Colors.red.withOpacity(0.5),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    bonus ? Icons.check : Icons.lock,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                    child: Text(
                                      bonus
                                          ? "Success"
                                          : AppLocalizations.of(context)!
                                              .locked,
                                      maxLines: 2,
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.reward} : ",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.green.shade300,
                            ),
                          ),
                          Text(
                            "\$$reward_amount",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.green.shade500,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      LinearPercentIndicator(
                        padding: EdgeInsets.zero,
                        animation: true,
                        lineHeight: 18,
                        barRadius: const Radius.circular(10),
                        animationDuration: 500,
                        percent: percent,
                        center: Text(
                          '$count / $target_count',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        progressColor: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
