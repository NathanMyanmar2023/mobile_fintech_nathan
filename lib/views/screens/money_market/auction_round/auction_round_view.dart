import 'package:flutter/material.dart';
import 'package:nathan_app/views/screens/money_market/auction_round/owner_round_detail_screen.dart';
import 'package:nathan_app/views/screens/money_market/auction_round/round_detail_screen.dart';
import 'package:nathan_app/views/screens/money_market/auction_round/start_round_detail_screen.dart';
import 'package:nathan_app/views/screens/money_market/auction_round/test_timer_view.dart';

import '../../../../bloc/money_market/auction_round_bloc.dart';
import '../../../../helpers/response_ob.dart';
import '../../../../objects/money_market/Auction_round_ob.dart';
import '../../../../resources/colors.dart';
import '../../../../widgets/nathan_text_view.dart';


class AuctionRoundView extends StatefulWidget {
  final int autionId;
  const AuctionRoundView({Key? key, required this.autionId}) : super(key: key);

  @override
  State<AuctionRoundView> createState() => _AuctionRoundViewState();
}

class _AuctionRoundViewState extends State<AuctionRoundView> {
  final scroll_controller = ScrollController();
  bool isLoading = true;


  final _auctionRound_bloc = AuctionRoundBloc();
  late Stream<ResponseOb> _auctionRound_stream;

  //payment metnod list
  List auctionRoundList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _auctionRound_stream = _auctionRound_bloc.auctionRoundStream();
    _auctionRound_stream.listen((ResponseOb resp) {
      if (resp.success) {
        auctionRoundList = (resp.data as AuctionRoundOb).data ?? [];
        print("auctionRoundList ${auctionRoundList.length}");
      } else {
        print("error");
      }
      setState(() {
        isLoading = false;
      });
    });
    _auctionRound_bloc.getAuctionRound(widget.autionId);
  }

  @override
  Widget build(BuildContext context) {

    return
      Expanded(
        child: GridView.builder(
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 2),
            crossAxisCount: 2, // number of items in each row
            mainAxisSpacing: 8.0, // spacing between rows
            crossAxisSpacing: 8.0, // spacing between columns
          ),
          padding: EdgeInsets.zero, // padding around the grid
          itemCount: auctionRoundList.length, // total number of items
          itemBuilder: (context, index) {
            return auctionRoundList[index].baseAmount == 0 ? const SizedBox() : InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (co) =>
                   // index == 0 ? const OwnerRoundDetailScreen() :
                   // index == 2 ?
                    StartRoundDetailScreen(roundId: auctionRoundList[index].id, roundNumber: auctionRoundList[index].roundNumber)
                        //:
                   //RoundDetailScreen(roundId: auctionRoundList[index].id, roundNumber: auctionRoundList[index].roundNumber,)
              //  TestTimerView()
                ));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: topColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${auctionRoundList[index].roundNumber}",
                      style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Real Amount - ${auctionRoundList[index].realAmount}",
                      style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Estimate - ${auctionRoundList[index].baseAmount}",
                      style: TextStyle(fontSize: 13.0, color: Colors.white,fontWeight: FontWeight.w600),
                    ),
                     Column(
                      children: [
                        Text(
                          auctionRoundList[index].userId == null ? "" : "Winner Bidder name",
                          style: TextStyle(fontSize: 14.0, color: Colors.white,fontWeight: FontWeight.w600),
                        ),
                        Text(
                          auctionRoundList[index].userId == null ? "" : "${auctionRoundList[index].userinfo.username ?? "Tun Tun"}",
                          style: TextStyle(fontSize: 18.0, color: colorPrimary,fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                )
              ),
            );
          },
        ),
      );

  }
}
