import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:nathan_app/objects/lucky_draw_ob.dart';
import 'package:rxdart/subjects.dart';

class LuckyDrawBloc extends BaseNetwork {
  final PublishSubject<ResponseOb> _luckyDrawController = PublishSubject();

  Stream<ResponseOb> luckyDrawStream() => _luckyDrawController.stream;

  luckyDraw() async {
    getReq(LUCKY_DRAW, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = LuckyDrawOb.fromJson(resp.data);
      }
      _luckyDrawController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      _luckyDrawController.sink.add(resp);
    });
  }
}
