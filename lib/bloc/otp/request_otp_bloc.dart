import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class RequestOtpBloc extends BaseNetwork {
  PublishSubject<ResponseOb> requestOtpController = PublishSubject();
  Stream<ResponseOb> requestOtpStream() => requestOtpController.stream;

  requestOtp({required String email}) async {
    postReq(REQUEST_OTP, params: {
      'email': email,
    }, onDataCallBack: (ResponseOb resp) {
      requestOtpController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      requestOtpController.sink.add(resp);
    });
  }
}
