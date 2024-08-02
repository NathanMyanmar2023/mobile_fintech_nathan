import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/lucky_draw_ob.dart';
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
