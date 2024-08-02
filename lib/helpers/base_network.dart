import 'package:dio/dio.dart';
import 'package:fnge/config/config.dart';
import 'package:fnge/helpers/response_data_ob.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/helpers/shared_pref.dart';

enum RequestType { Get, Post, Del }

class BaseNetwork {
  void getReq(String url,
      {Map<String, String>? params,
      Function? onDataCallBack,
      Function? errorCallBack}) async {
    requestData(RequestType.Get,
        url: url,
        params: params,
        onDataCallBack: onDataCallBack,
        errorCallBack: errorCallBack);
  }

  void postReq(String url,
      {Map<String, dynamic>? params,
      FormData? fd,
      Function? onDataCallBack,
      Function? errorCallBack}) async {
    requestData(RequestType.Post,
        url: url,
        params: params,
        fd: fd,
        onDataCallBack: onDataCallBack,
        errorCallBack: errorCallBack);
  }

  void delReq(String url,
      {Map<String, dynamic>? params,
      FormData? fd,
      Function? onDataCallBack,
      Function? errorCallBack}) async {
    requestData(RequestType.Del,
        url: url,
        params: params,
        fd: fd,
        onDataCallBack: onDataCallBack,
        errorCallBack: errorCallBack);
  }

  //Request Data
  void requestData(RequestType rt,
      {required String url,
      Map<String, dynamic>? params,
      FormData? fd,
      Function? onDataCallBack,
      Function? errorCallBack}) async {
    BaseOptions options = BaseOptions();
    // options.connectTimeout = 10000;
    // options.receiveTimeout = 10000;

    String? token = await SharedPref.getData(key: SharedPref.token);
    String? language = await SharedPref.getData(key: SharedPref.language_code);
    // print(token);

    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["X-API-KEY"] = Config.apiKey;
    dio.options.headers["setLanguage"] = language;
    int isPasswordReset = 0;
    try {
      Response response;
      if (rt == RequestType.Get) {
        if (params == null) {
          response = await dio.get(url);
        } else {
          response = await dio.get(url, queryParameters: params);
        }
      } else if (rt == RequestType.Del) {
        if (params != null || fd != null) {
          response = await dio.delete(url, data: fd ?? params);
        } else {
          response = await dio.delete(url);
        }
      } else {
        if (params != null || fd != null) {
          response = await dio.post(url, data: fd ?? params);
        } else {
          response = await dio.post(url);
        }
      }

      int? statusCode = response.statusCode;
      ResponseOb respOb = ResponseOb(success: false); //data,message,err
      ResponseDataOb respDataOb = ResponseDataOb(status: "fail");

      if (statusCode == 200 && response.data["success"] == true) {
        //data
        respOb.success = response.data["success"];
        respOb.message = response.data["message"];
        respOb.data = response.data;
        onDataCallBack!(respOb);
      } else if (statusCode == 400 && response.data["success"] == false) {
        // when data is null
        respOb.message = response.data["message"];
        errorCallBack!(respOb);
      } else if (statusCode == 200 && response.data["status"] == true) {
        // for checking deposit resp
        //data
        respOb.message = response.data["message"];
        errorCallBack!(respOb);
      } else {
        //error
        respOb.success = response.data["success"];
        respOb.message = response.data["message"];
        errorCallBack!(respOb);
      }
    } on DioError catch (e) {
      print("DioError code ${e.response?.statusCode}");
      ResponseOb respObb = ResponseOb(success: false);
      print("DioError ${e.response?.data['message']}");
      SharedPref.setData(
        key: SharedPref.responseError,
        value: e.response?.data['message'],
      );
      ResponseOb respOb = ResponseOb(success: false);
      print("res ${respOb.message}");
      if (e.response?.data["success"] == false) {
        if (e.response?.data["message"] != null) {
          respOb.message = e.response?.data["message"];
        } else {
          respOb.message = "Server Error 1";
        }
      } else if (e.response?.statusCode == 422) {
        print("4222");
        if (e.response?.data['message'] ==
            "The new password field is required. (and 1 more error)") {
          e.response?.data["success"] = true;
          e.response?.data["message"] = "Unprocessable Entity";
          onDataCallBack!(respObb);
        }
        return; // Return early to prevent further processing
      } else {
        respOb.success = e.response?.data["success"] != null
            ? e.response != null
                ? e.response?.data["success"]
                : false
            : false;
        respOb.message =
            e.response != null ? e.response?.data["message"] : "Server Error";
      }

      // print(e.response?.data["status"]);
      if (e.response?.data["authorized"] == false) {
        SharedPref.clear();
        respOb.authorized = false;
      }
      errorCallBack!(respOb);
    }
  }
}
