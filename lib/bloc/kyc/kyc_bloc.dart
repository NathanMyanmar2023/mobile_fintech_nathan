import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mime/mime.dart';
import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/presign_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as Path;
import 'dart:developer';

class KycBloc extends BaseNetwork {
  PublishSubject<ResponseOb> photoPresignController = PublishSubject();

  PublishSubject<ResponseOb> uploadKycController = PublishSubject();
  Stream<ResponseOb> uploadKycStream() => uploadKycController.stream;

  Map<String, dynamic> kyc_map = {};
  int upload_image_count = 0;

  uploadKyc(Map<String, dynamic> map, File? photo, File? nrcFront, File? nrcBack, File? bankStatement) {
    kyc_map.addAll(map);

    upload_image_to_space(photo!, "photo");
    upload_image_to_space(nrcFront!, "front_nrc");
    upload_image_to_space(nrcBack!, "back_nrc");
    upload_image_to_space(bankStatement!, "bank_statement");
  }

  upload_image_to_space(File file, String type) {
    // log("uploading ${type} ....");
    var uuid = const Uuid();
    String name = uuid.v1();
    String fullName = name + Path.extension(file.path);
    String path = "Nathan/Kyc";
    Map<String, dynamic> presignMap = {
      'name': fullName,
      'path': path,
    };

    postReq(PRESIGN, params: presignMap, onDataCallBack: (ResponseOb resp) async {
      if (resp.success == true) {
        if(kIsWeb) {
          resp.data = PresignOb.fromJson(resp.data);
        } else {
          resp.data = PresignOb.fromJson(resp.data);
        }
        String presignUrl = resp.data.data.presign.toString();
        Uint8List image = file.readAsBytesSync();
        Options options = Options(contentType: lookupMimeType(file.path), headers: {
          'Accept': "*/*",
          'Content-Length': image.length,
          'Connection': 'keep-alive',
          'x-amz-acl': 'public-read',
        });
        Dio dio = Dio();
        Response response = await dio.put(presignUrl, data: Stream.fromIterable(image.map((e) => [e])), options: options);
        //if upload image success
        if (response.statusCode == 200) {
          kyc_map.addAll({"${type}_name": fullName, "${type}_path": path});
          upload_image_count++;
          if (upload_image_count > 3) {
            log(kyc_map.toString());
            upload_datas();
          }
        } else {
          log("error1");
          return;
        }
      } else {
        uploadKycController.sink.add(resp);
        log("error2");
        return;
      }
    }, errorCallBack: (ResponseOb resp) {
      uploadKycController.sink.add(resp);
      log("error3");
      return;
    });
  }

  upload_datas() {
    postReq(
      UPLOAD_KYC,
      params: kyc_map,
      onDataCallBack: (ResponseOb resp) {
        uploadKycController.sink.add(resp);
      },
      errorCallBack: (ResponseOb resp) {
        uploadKycController.sink.add(resp);
      },
    );
  }
}
