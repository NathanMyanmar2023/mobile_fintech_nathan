import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/application_fee_ob.dart';
import 'package:rxdart/subjects.dart';

class ApplicationFeesHistoryBloc extends BaseNetwork {
  PublishSubject<ResponseOb> applicationFeesController = PublishSubject();

  Stream<ResponseOb> applicationFeesStream() =>
      applicationFeesController.stream;

  getApplicationFeesHistory(int page) async {
    getReq("${API_URL}history/application/fees?page=$page",
        onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = ApplicationFeeOb.fromJson(resp.data);
      }
      applicationFeesController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      applicationFeesController.sink.add(resp);
    });
  }
}
