import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/winner_ob.dart';
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
