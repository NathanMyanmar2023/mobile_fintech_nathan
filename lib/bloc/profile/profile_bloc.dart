import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/presign_ob.dart';
import 'package:nathan_app/objects/profile/update_profile_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as Path;

class ProfileBloc extends BaseNetwork {
  PublishSubject<ResponseOb> presignController = PublishSubject();
  Stream<ResponseOb> presignStream() => presignController.stream;

  PublishSubject<ResponseOb> profileController = PublishSubject();
  Stream<ResponseOb> profileStream() => profileController.stream;

  updateProfile(Map<String, dynamic> map) async {
    //TODO:send deposit request
    postReq(
      UPDATE_PROFILE,
      params: map,
      onDataCallBack: (ResponseOb resp) {
        if (resp.success == true) {
          resp.data = UpdateProfileOb.fromJson(resp.data);
        }
        profileController.sink.add(resp);
      },
      errorCallBack: (ResponseOb resp) {
        profileController.sink.add(resp);
      },
    );
  }

  updateProfileWithPicture(Map<String, dynamic> map, File file) async {
    //TODO:generate name and path for presign
    var uuid = const Uuid();
    String imageName = uuid.v1();
    String imageFullName = imageName + Path.extension(file.path);
    String imagePath = "Nathan/ProfilePictures";
    Map<String, dynamic> presignMap = {
      'name': imageFullName,
      'path': imagePath,
    };

    //TODO:get presign url
    postReq(PRESIGN, params: presignMap, onDataCallBack: (ResponseOb resp) async {
      if (resp.success == true) {
        resp.data = PresignOb.fromJson(resp.data);
        String presignUrl = resp.data.data.presign.toString();

        //TODO:upload image to space
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
          map.addAll({"image_name": imageFullName, "image_path": imagePath});
        }

        //TODO:send deposit request
        postReq(
          UPDATE_PROFILE,
          params: map,
          onDataCallBack: (ResponseOb resp) {
            if (resp.success == true) {
              resp.data = UpdateProfileOb.fromJson(resp.data);
            }
            profileController.sink.add(resp);
          },
          errorCallBack: (ResponseOb resp) {
            profileController.sink.add(resp);
          },
        );
      } else {
        presignController.sink.add(resp);
      }
    }, errorCallBack: (ResponseOb resp) {
      // if getting presign get error
      presignController.sink.add(resp);
    });
  }
}
