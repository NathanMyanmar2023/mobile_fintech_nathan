import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mime/mime.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/deposit/deposit_ob.dart';
import 'package:fnge/objects/presign_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as Path;

class RequestDepositBloc extends BaseNetwork {
  PublishSubject<ResponseOb> presignController = PublishSubject();
  Stream<ResponseOb> presignStream() => presignController.stream;

  PublishSubject<ResponseOb> requestDepositController = PublishSubject();
  Stream<ResponseOb> requestDepositStream() => requestDepositController.stream;

  requestDeposit(Map<String, dynamic> map, File file) async {
    //TODO:generate name and path for presign
    var uuid = const Uuid();
    String imageName = uuid.v1();
    String imageFullName = imageName + Path.extension(file.path);
    String imagePath = "Nathan/Deposit";
    print("imageFullName ${imageFullName}");
    Map<String, dynamic> presignMap = {
      'name': imageFullName,
      'path': imagePath,
    };

    //TODO:get presign url
    postReq(PRESIGN, params: presignMap,
        onDataCallBack: (ResponseOb resp) async {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = PresignOb.fromJson(resp.data);
        } else {
          resp.data = PresignOb.fromJson(resp.data);
        }
        String presignUrl = resp.data.data.presign.toString();
        print("doofo 4${resp.data}");
        //TODO:upload image to space
        Uint8List image = file.readAsBytesSync();
        Options options =
            Options(contentType: lookupMimeType(file.path), headers: {
          'Accept': "*/*",
          'Content-Length': image.length,
          'Connection': 'keep-alive',
          'x-amz-acl': 'public-read',
        });

        Dio dio = Dio();
        Response response = await dio.put(presignUrl,
            data: Stream.fromIterable(image.map((e) => [e])), options: options);
        //if upload image success
        print("doodo ${response.statusCode}");
        if (response.statusCode == 200) {
          map.addAll({"image_name": imageFullName, "image_path": imagePath});
          //TODO:send deposit request
          print("ododo odofinfo ${map}");
          postReq(
            DEPOSIT,
            params: map,
            onDataCallBack: (ResponseOb resp) {
              print("DEPOSIT ${resp.success}");
              if (resp.success == true) {
                if (kIsWeb) {
                  resp.data = DepositOb.fromJson(resp.data);
                } else {
                  resp.data = DepositOb.fromJson(resp.data);
                }
                print("DEPOSIT dat ${resp.data}");
              }
              requestDepositController.sink.add(resp);
            },
            errorCallBack: (ResponseOb resp) {
              requestDepositController.sink.add(resp);
            },
          );
        }
      } else {
        presignController.sink.add(resp);
      }
    }, errorCallBack: (ResponseOb resp) {
      // if getting presign get error
      presignController.sink.add(resp);
    });
  }
}
