import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nathan_app/bloc/winner_bloc.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/winner_ob.dart';
import 'package:nathan_app/resources/colors.dart';

class WinnerPage extends StatefulWidget {
  const WinnerPage({super.key});

  @override
  State<WinnerPage> createState() => _WinnerPageState();
}

class _WinnerPageState extends State<WinnerPage> {
  final _winnerBloc = WinnerBloc();
  late Stream<ResponseOb> _winnerStream;
  List<WinnerData> winnerList = [];

  @override
  void initState() {
    super.initState();
    _winnerStream = _winnerBloc.winnerStream();
    _winnerStream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          winnerList = (resp.data as WinnerOb).data ?? [];
        });
      } else {}
    });

    _winnerBloc.getWinner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            title: const Text(
              "Winners",
              style: TextStyle(
                fontSize: 16,
                color: colorPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: winnerList.length,
        padding: const EdgeInsets.only(bottom: 8),
        itemBuilder: (BuildContext context, int index) => WinnerView(
          winnerData: winnerList[index],
        ),
      ),
    );
  }
}

class WinnerView extends StatelessWidget {
  final WinnerData winnerData;

  const WinnerView({
    super.key,
    required this.winnerData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
          child: Text(
            winnerData.prizeName ?? "-",
            style: const TextStyle(
              color: colorPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
        ),
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: const EdgeInsets.only(
            top: 12,
            left: 12,
            right: 12,
          ),
          child: Container(
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
                CachedNetworkImage(
                  height: MediaQuery.of(context).size.height * 0.2,
                  fit: BoxFit.cover,
                  imageUrl: winnerData.userImage ?? "",
                  width: double.infinity,
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
                      "${winnerData.data ?? 0}",
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
                          winnerData.userName ?? "-",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Prize : ${winnerData.prize}",
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
        ),
      ],
    );
  }
}
