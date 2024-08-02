import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/check_refer_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';
import 'package:http/http.dart' as http;

class CheckReferBloc extends BaseNetwork {
  PublishSubject<ResponseOb> checkReferController = PublishSubject();
  Stream<ResponseOb> checkReferStream() => checkReferController.stream;
  checkRefer(String referCode) async {
    final response = await http.get(Uri.parse('https://api.ipify.org'));
    String deviceIp = response.body.toString();

    Map<String, dynamic> map = {
      "refer_code": referCode,
      "ip_address": deviceIp
    };

    postReq(CHECK_REFER, params: map, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = CheckReferOb.fromJson(resp.data);
        } else {
          resp.data = CheckReferOb.fromJson(resp.data);
        }
      }
      checkReferController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      checkReferController.sink.add(resp);
    });
  }
}
