import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nathan_app/bloc/lucky_draw_bloc.dart';
import 'package:nathan_app/extensions/navigation_extensions.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/lucky_draw_ob.dart';
import 'package:nathan_app/pages/buy_ticket_page.dart';
import 'package:nathan_app/pages/my_ticket_page.dart';
import 'package:nathan_app/pages/winner_page.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/resources/constants.dart';
import 'package:nathan_app/widgets/long_button_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/app_bar_title_view.dart';

class LuckyDrawPage extends StatefulWidget {
  final String currency;
  const LuckyDrawPage({
    super.key,
    required this.currency,
  });

  @override
  State<LuckyDrawPage> createState() => _LuckyDrawPageState();
}

class _LuckyDrawPageState extends State<LuckyDrawPage> {
  final _luckyDrawBloc = LuckyDrawBloc();
  late Stream<ResponseOb> _luckyDrawStream;
  List<LuckyDrawData> luckyDrawList = [];

  @override
  void initState() {
    super.initState();

    _luckyDrawStream = _luckyDrawBloc.luckyDrawStream();
    _luckyDrawStream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          luckyDrawList = (resp.data as LuckyDrawOb).data ?? [];
        });
      } else {}
    });

    _luckyDrawBloc.luckyDraw();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBarTitleView(text: AppLocalizations.of(context)!.lucky_draw,),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(12),
              child: Row(
                children: [
                   Text(
                    AppLocalizations.of(context)!.see_who_lucky_draw_winner,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => const WinnerPage(),
                        ),
                      );
                    },
                    child:  Text(
                      AppLocalizations.of(context)!.show,
                      style: const TextStyle(
                        fontSize: 14,
                        color: colorPrimary,
                        fontWeight: FontWeight.w800,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            luckyDrawList.isEmpty ?
             Padding(
              padding: const EdgeInsets.only(top: 50),
              child:  Center(
                child: Text(
                  AppLocalizations.of(context)!.no_more_data,),
              ),
            ) : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: luckyDrawList.length,
              padding: const EdgeInsets.only(bottom: 8),
              itemBuilder: (BuildContext context, int index) => LuckyDrawView(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => BuyTicketPage(
                      luckyDraw: luckyDrawList[index],
                    ),
                  ),
                ),
                luckyDrawData: luckyDrawList[index],
                currency: widget.currency,
                onTapImage: (url) => showImageDialog(context, url),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            color: colorGrey,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          GestureDetector(
            onTap: () => popBack(context: context),
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorWhite.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: colorPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LuckyDrawView extends StatelessWidget {
  final String currency;
  final LuckyDrawData luckyDrawData;
  final Function onTap;
  final Function(String) onTapImage;

  const LuckyDrawView({
    super.key,
    required this.onTap,
    required this.luckyDrawData,
    required this.currency,
    required this.onTapImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
      ),
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                GestureDetector(
                  onTap: () => onTapImage(luckyDrawData.poster ?? ""),
                  child: CachedNetworkImage(
                    height: MediaQuery.of(context).size.height * 0.2,
                    fit: BoxFit.cover,
                    imageUrl: luckyDrawData.poster ?? "",
                    width: double.infinity,
                    placeholder: (context, url) => Image.asset(
                      appLogo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  color: Colors.black.withOpacity(0.1),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey.withOpacity(
                        0.7,
                      ),
                    ),
                    child: Text(
                      "${luckyDrawData.maxTicket ?? 0}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.only(
                      bottom: 12,
                      top: 12,
                      left: 12,
                      right: 12,
                    ),
                    color: colorBlack.withOpacity(0.3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          luckyDrawData.name ?? "-",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${AppLocalizations.of(context)!.price} : ${luckyDrawData.price} $currency",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          LongButtonView(
            text: AppLocalizations.of(context)!.buy_ticket,
            borderRadius: BorderRadius.zero,
            onTap: () => onTap(),
            backgroundColor: colorPrimary.withOpacity(0.8),
          ),
        ],
      ),
    );
  }
}
