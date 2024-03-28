import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/check_refer_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';
import 'package:http/http.dart' as http;

class CheckReferBloc extends BaseNetwork {
  PublishSubject<ResponseOb> checkReferController = PublishSubject();
  Stream<ResponseOb> checkReferStream() => checkReferController.stream;
  checkRefer(String referCode) async {
    final response = await http.get(Uri.parse('https://api.ipify.org'));
    String deviceIp = response.body.toString();

    Map<String, dynamic> map = {"refer_code": referCode, "ip_address": deviceIp};

    postReq(CHECK_REFER, params: map, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = CheckReferOb.fromJson(resp.data);
      }
      checkReferController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      checkReferController.sink.add(resp);
    });
  }
}
