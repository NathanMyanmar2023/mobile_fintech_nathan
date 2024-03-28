import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/network/levels_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class LevelsBloc extends BaseNetwork {
  PublishSubject<ResponseOb> levelsController = PublishSubject();
  Stream<ResponseOb> levelsStream() => levelsController.stream;

  getLevels() async {
    getReq(GET_LEVELS, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = LevelsOb.fromJson(resp.data);
      }
      levelsController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      levelsController.sink.add(resp);
    });
  }
}
