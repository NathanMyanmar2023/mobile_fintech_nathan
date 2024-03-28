import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nathan_app/bloc/buy_ticket_bloc.dart';
import 'package:nathan_app/bloc/check_ticket_bloc.dart';
import 'package:nathan_app/extensions/navigation_extensions.dart';
import 'package:nathan_app/extensions/string_extensions.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/buy_ticket_ob.dart';
import 'package:nathan_app/objects/check_ticket_ob.dart';
import 'package:nathan_app/objects/lucky_draw_ob.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:nathan_app/views/widgets/error_alert_widget.dart';
import 'package:nathan_app/widgets/long_button_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuyTicketPage extends StatefulWidget {
  final LuckyDrawData luckyDraw;
  const BuyTicketPage({
    super.key,
    required this.luckyDraw,
  });

  @override
  State<BuyTicketPage> createState() => _BuyTicketPageState();
}

class _BuyTicketPageState extends State<BuyTicketPage> {
  var ticketTec = TextEditingController();
  bool isLoading = false;

  final _checkTicketBloc = CheckTicketBloc();
  late Stream<ResponseOb> _checkTicketStream;

  final _buyTicketBloc = BuyTicketBloc();
  late Stream<ResponseOb> _buyTicketStream;

  @override
  void initState() {
    super.initState();

    /// check available ticket stream listen
    _checkTicketEvent();

    /// buy available ticket stream listen
    _buyTicketEvent();
  }

  void _buyTicketEvent() {
    _buyTicketStream = _buyTicketBloc.buyTicketStream();
    _buyTicketStream.listen((ResponseOb resp) {
      setState(() {
        isLoading = false;
      });
      if (resp.success) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text((resp.data as BuyTicketOb).message ?? "-"),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('images/welcome.png', height: 100, width: 100),
                    const SizedBox(height: 10),
                    Text(
                      "Your ticket${((resp.data as BuyTicketOb).data?.length ?? 0) > 1 ? "s are" : " is"} ${(resp.data as BuyTicketOb).data?.join(",") ?? " - "}.",
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      popBack(context: context);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: colorPrimary,
                      ),
                    ),
                  ),
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('images/welcome.png', height: 100, width: 100),
                    const SizedBox(height: 10),
                    Text(
                      resp.message.toString(),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      popBack(context: context);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: colorPrimary,
                      ),
                    ),
                  ),
                ],
              );
            });
        return;
      }
    });
  }

  void _checkTicketEvent() {
    _checkTicketStream = _checkTicketBloc.checkTicketStream();
    _checkTicketStream.listen((ResponseOb resp) {
      setState(() {
        isLoading = false;
      });
      if (resp.success) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(AppLocalizations.of(context)!.ticket_are_available),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('images/welcome.png', height: 100, width: 100),
                    const SizedBox(height: 10),
                    Text(
                      "Ticket number ${(resp.data as CheckTicketOb).data?.join(",") ?? "-"} ${((resp.data as CheckTicketOb).data?.length ?? 0) > 1 ? "are" : "is"} available. Are you sure that you like to buy this ticket?",
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      buyTicket();
                      popBack(context: context);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: colorPrimary,
                      ),
                    ),
                  ),
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('images/welcome.png', height: 100, width: 100),
                    const SizedBox(height: 10),
                    Text(
                      resp.message.toString(),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      popBack(context: context);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: colorPrimary,
                      ),
                    ),
                  ),
                ],
              );
            });
        return;
      }
    });
  }

  void checkTicket() {
    if (ticketTec.text.isNullOrEmpty()) {
      showDialog(
          context: context,
          builder: (context) {
            return ErrorAlert(
              "Error",
              Image.asset('images/welcome.png'),
              "Enter ticket number.",
            );
          });
      return;
    }

    Map<String, dynamic> map = {
      "prize_id": widget.luckyDraw.id,
      "lucky_no": ticketTec.text
          .trim()
          .split(' ')
          .map((String number) {
            number = number.replaceAll(RegExp(r'[^0-9]'), '');
            return int.parse(number);
          })
          .toSet()
          .toList(),
    };
    _checkTicketBloc.checkTicket(data: map);
    setState(() {
      isLoading = true;
    });
  }

  void buyTicket() {
    Map<String, dynamic> map = {
      "prize_id": widget.luckyDraw.id,
      "lucky_no": ticketTec.text
          .trim()
          .split(' ')
          .map((String number) {
            number = number.replaceAll(RegExp(r'[^0-9]'), '');
            return int.parse(number);
          })
          .toSet()
          .toList(),
      "wallet": 1,
    };
    _buyTicketBloc.buyTicket(data: map);
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? MediaQuery(
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
          )
        : Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: AppBar(
                  toolbarHeight: 70,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: colorPrimary,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  title:  Text(
                    AppLocalizations.of(context)!.buy_ticket,
                    style: TextStyle(
                      fontSize: 16,
                      color: colorPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.luckyDraw.name ?? "-",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                     Text(
                      AppLocalizations.of(context)!.chosse_ur_ticket_no_available_buy,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: ticketTec,
                      onChanged: (value) {
                        // ticketTec.text = value.replaceAll(RegExp(r'\D'), ',');
                        String cleanedValue =
                            value.replaceAll(RegExp(r'[^0-9,]+'), ' ');
                        cleanedValue =
                            cleanedValue.replaceAll(RegExp(r' {2,}'), ' ');

                        ticketTec.text = cleanedValue;
                      },
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.check_ticket_want_here,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    LongButtonView(
                      text: AppLocalizations.of(context)!.check_ticket_available,
                      onTap: () => checkTicket(),
                    ),
                    const SizedBox(height: 16.0),
                     Text(
                       AppLocalizations.of(context)!.prizes,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: colorPrimary,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.luckyDraw.prizes?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) =>
                          PrizeView(
                        prize: widget.luckyDraw.prizes?[index],
                        onTap: (imageUrl) => showImageDialog(context, imageUrl),
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                     Text(AppLocalizations.of(context)!.rules,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: colorPrimary,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      widget.luckyDraw.rules ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
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

class PrizeView extends StatelessWidget {
  final Prizes? prize;
  final Function(String) onTap;

  const PrizeView({
    super.key,
    required this.prize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(prize?.photo ?? ""),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.only(
          bottom: 12,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CachedNetworkImage(
              height: MediaQuery.of(context).size.height * 0.2,
              fit: BoxFit.cover,
              imageUrl: prize?.photo ?? "",
              width: double.infinity,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              color: colorGrey.withOpacity(0.7),
              child: Text(
                prize?.name ?? "-",
                style: const TextStyle(
                  color: colorWhite,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final StringBuffer newText = StringBuffer();

    for (int i = 0; i < newValue.text.length; i++) {
      newText.write(newValue.text[i]);

      if ((i + 1) % 3 == 0 && i != newValue.text.length - 1) {
        newText.write(' ');
      }
    }

    return newValue.copyWith(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
