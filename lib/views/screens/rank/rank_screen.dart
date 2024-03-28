import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/bloc/rank/rank_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
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

  int is_y_plan = 0;
  int is_ic = 0;
  int is_supervisor = 0;
  int is_manager = 0;
  int is_general_manager = 0;
  int is_director = 0;
  int is_president = 0;
  int is_owner = 0;
  int y_plan_count = 0;
  int ic_count = 0;
  int supervisor_count = 0;
  int manager_count = 0;
  int general_manager_count = 0;
  int director_count = 0;
  int president_count = 0;
  int owner_count = 0;
  int one_time_bonus_count = 0;

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
       //    is_owner = resp.data.data.isOwner;
       //    y_plan_count = resp.data.data.yPlanCount;
       //    ic_count = resp.data.data.icCount;
       //    supervisor_count = resp.data.data.supervisorCount;
       //    manager_count = resp.data.data.managerCount;
       //    general_manager_count = resp.data.data.generalManagerCount;
       //    director_count = resp.data.data.directorCount;
       //    president_count = resp.data.data.presidentCount;
       //    owner_count = resp.data.data.ownerCount;
       //    one_time_bonus_count = resp.data.data.oneTimeBonusCount;

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
        data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
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
                      if (is_y_plan == 0)
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            color: Colors.red,
                            child:  Row(
                              children: [
                                Icon(
                                  Icons.lock,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Text(
                                    AppLocalizations.of(context)!.locked,
                                    maxLines: 2,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 16,
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
                ),
                const SizedBox(
                  height: 10,
                ),
                if (is_y_plan == 0)
                  Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        size: 15,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          AppLocalizations.of(context)!.invest_10USD,
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ],
                  ),
                RankWidget(
                  count: y_plan_count,
                  target_count: 39,
                  status: is_y_plan,
                  percent: y_plan_count / 39,
                  message: AppLocalizations.of(context)!.need_39_10USD,
                  title: AppLocalizations.of(context)!.ic,
                  reward_amount: "31.20",
                  icon: Icons.account_tree_outlined,
                  icon_name: 'ic_rank.png',
                  color: Colors.green,
                  bg_color: Colors.green.shade50,
                ),
                const SizedBox(
                  height: 20,
                ),
                RankWidget(
                  count: supervisor_count,
                  target_count: 8,
                  status: is_supervisor,
                  percent: supervisor_count / 8,
                  message: AppLocalizations.of(context)!.need_8_ic,
                  title: AppLocalizations.of(context)!.supervisor,
                  reward_amount: "156.00",
                  icon: Icons.supervisor_account_rounded,
                  icon_name: 'supervisor_rank.png',
                  color: Colors.green,
                  bg_color: Colors.green.shade50,
                ),
                const SizedBox(
                  height: 20,
                ),
                RankWidget(
                  count: manager_count,
                  target_count: 8,
                  status: is_manager,
                  percent: manager_count / 8,
                  message: AppLocalizations.of(context)!.need_8_supervisor,
                  title: AppLocalizations.of(context)!.manager,
                  reward_amount: "748.80",
                  icon: Icons.manage_accounts_outlined,
                  icon_name: 'manager_rank.png',
                  color: Colors.green,
                  bg_color: Colors.green.shade50,
                ),
                const SizedBox(
                  height: 20,
                ),
                RankWidget(
                  count: general_manager_count,
                  target_count: 8,
                  status: is_general_manager,
                  percent: general_manager_count / 8,
                  message: AppLocalizations.of(context)!.need_8_manager,
                  title: AppLocalizations.of(context)!.general_manager,
                  reward_amount: "3,993.60",
                  icon: Icons.groups,
                  icon_name: 'general_manager_rank.png',
                  color: Colors.green,
                  bg_color: Colors.green.shade50,
                ),
                const SizedBox(
                  height: 20,
                ),
                RankWidget(
                  count: supervisor_count,
                  target_count: 8,
                  status: is_supervisor,
                  percent: supervisor_count / 8,
                  message: AppLocalizations.of(context)!.need_8_general_mana,
                  title: AppLocalizations.of(context)!.director,
                  reward_amount: "15,974.40",
                  icon: Icons.supervised_user_circle_outlined,
                  icon_name: 'director_rank.png',
                  color: Colors.green,
                  bg_color: Colors.green.shade50,
                ),
                const SizedBox(
                  height: 20,
                ),
                RankWidget(
                  count: supervisor_count,
                  target_count: 8,
                  status: is_supervisor,
                  percent: supervisor_count / 8,
                  message: AppLocalizations.of(context)!.need_8_director,
                  title: AppLocalizations.of(context)!.president,
                  reward_amount: "102,236.16",
                  icon: Icons.supervised_user_circle_outlined,
                  icon_name: 'owner_rank.png',
                  color: Colors.green,
                  bg_color: Colors.green.shade50,
                ),
                const SizedBox(
                  height: 20,
                ),
                RankWidget(
                  count: supervisor_count,
                  target_count: 8,
                  status: is_supervisor,
                  percent: supervisor_count / 8,
                  message: AppLocalizations.of(context)!.need_8_president,
                  title: AppLocalizations.of(context)!.owner,
                  reward_amount: "511,180.80",
                  icon: Icons.supervised_user_circle_outlined,
                  icon_name: 'president_rank.png',
                  color: Colors.green,
                  bg_color: Colors.green.shade50,
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
    required this.status,
    required this.percent,
    required this.message,
    required this.title,
    required this.reward_amount,
    required this.icon,
    required this.icon_name,
    required this.color,
    required this.bg_color,
  });

  final int count;
  final int target_count;
  final int status;
  final double percent;
  final String message;
  final String title;
  final String reward_amount;
  final IconData icon;
  final String icon_name;
  final Color color;
  final Color bg_color;

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
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
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
