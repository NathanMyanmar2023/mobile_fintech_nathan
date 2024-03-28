import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:nathan_app/objects/winner_ob.dart';
import 'package:rxdart/subjects.dart';

class WinnerBloc extends BaseNetwork {
  PublishSubject<ResponseOb> winnerController = PublishSubject();

  Stream<ResponseOb> winnerStream() => winnerController.stream;

  getWinner() async {
    getReq(WINNER, onDataCallBack: (ResponseOb resp) {
      resp.data = WinnerOb.fromJson(resp.data);
      winnerController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      winnerController.sink.add(resp);
    });
  }
}
