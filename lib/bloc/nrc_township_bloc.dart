import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:nathan_app/objects/Nrc_type_ob.dart';
import 'package:nathan_app/objects/region_ob.dart';
import 'package:rxdart/subjects.dart';

import '../objects/Nrc_township_list_ob.dart';

class NRCTownshipBloc extends BaseNetwork {
  PublishSubject<ResponseOb> nrcTownshipController = PublishSubject();

  Stream<ResponseOb> nrcTownshipStream() => nrcTownshipController.stream;

  getNRCTownShip(String id) async {
    getReq("$NRC_TOWNSHIP$id", onDataCallBack: (ResponseOb resp) {
      nrcTownshipController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      nrcTownshipController.sink.add(resp);
    });
  }
}
