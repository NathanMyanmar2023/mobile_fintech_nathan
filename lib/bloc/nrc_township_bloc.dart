import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/Nrc_type_ob.dart';
import 'package:fnge/objects/region_ob.dart';
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
