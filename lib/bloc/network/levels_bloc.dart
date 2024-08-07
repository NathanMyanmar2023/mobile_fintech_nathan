import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/network/levels_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class LevelsBloc extends BaseNetwork {
  PublishSubject<ResponseOb> levelsController = PublishSubject();
  Stream<ResponseOb> levelsStream() => levelsController.stream;

  getLevels() async {
    getReq(GET_LEVELS, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = LevelsOb.fromJson(resp.data);
        } else {
          resp.data = LevelsOb.fromJson(resp.data);
        }
      }
      levelsController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      levelsController.sink.add(resp);
    });
  }
}
