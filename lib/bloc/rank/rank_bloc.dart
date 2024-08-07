import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/rank/rank_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class RankBloc extends BaseNetwork {
  PublishSubject<ResponseOb> rankController = PublishSubject();
  Stream<ResponseOb> rankStream() => rankController.stream;

  getRank() {
    getReq(RANK, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = RankOb.fromJson(resp.data);
      }
      rankController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      rankController.sink.add(resp);
    });
  }
}
