import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fnge/bloc/my_ticket_bloc.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/my_ticket_ob.dart';
import 'package:fnge/resources/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyTicketPage extends StatefulWidget {
  const MyTicketPage({super.key});

  @override
  State<MyTicketPage> createState() => _MyTicketPageState();
}

class _MyTicketPageState extends State<MyTicketPage> {
  bool isLoading = false;
  final _myTicketBloc = MyTicketBloc();
  late Stream<ResponseOb> _myTicketStream;
  List<TicketData> _myTicketList = [];

  @override
  void initState() {
    super.initState();

    _myTicketStream = _myTicketBloc.myTicketStream();
    _myTicketStream.listen((ResponseOb resp) {
      setState(() {
        isLoading = false;
      });
      if (resp.success) {
        setState(() {
          _myTicketList = (resp.data as MyTicketOb).data ?? [];
        });
      } else {}
    });

    _myTicketBloc.getMyTicket();
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
                  title: Text(
                    AppLocalizations.of(context)!.my_tickets,
                    style: const TextStyle(
                      fontSize: 16,
                      color: colorPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: _myTicketList.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.no_more_data,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _myTicketList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) =>
                          TicketListView(
                        ticketData: _myTicketList[index],
                      ),
                    ),
            ),
          );
  }
}

class TicketListView extends StatelessWidget {
  final TicketData ticketData;

  const TicketListView({
    super.key,
    required this.ticketData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 12,
            left: 12,
            right: 12,
          ),
          child: Text(
            ticketData.prize ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: colorPrimary,
              fontSize: 18,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ticketData.tickets?.length ?? 0,
          padding: const EdgeInsets.only(bottom: 12),
          itemBuilder: (BuildContext context, int index) => MyTicketView(
            ticket: ticketData.tickets?[index],
          ),
        ),
      ],
    );
  }
}

class MyTicketView extends StatelessWidget {
  final Tickets? ticket;

  const MyTicketView({
    super.key,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            colorPrimary.withOpacity(0.8),
            colorPrimary,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ticket?.prizeName ?? "-",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "${ticket?.ticketNo ?? " - "}",
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TicketDateView(
                title: "Buy Date",
                date: ticket?.buyDate ?? "-",
              ),
              TicketDateView(
                title: "Open Date",
                date: ticket?.openDate ?? "-",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TicketDateView extends StatelessWidget {
  final String title;
  final String? date;

  const TicketDateView({
    super.key,
    required this.date,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
        Text(
          date ?? "",
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
