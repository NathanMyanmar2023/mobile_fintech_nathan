class DataResponse {
  DataResponse({
      this.id, 
      this.name, 
      this.username, 
      this.email, 
      this.emailVerifiedAt, 
      this.phone, 
      this.verifyCodeSendAt, 
      this.verifyCodeSendCount, 
      this.verifyCode, 
      this.verifyAttemptCount, 
      this.lastVerifyAttemptAt, 
      this.phoneVerifiedAt, 
      this.imagePath, 
      this.imageName, 
      this.imageLocation, 
      this.role, 
      this.isBan, 
      this.isEditor, 
      this.isAdmin, 
      this.parentId, 
      this.referCode, 
      this.createdAt, 
      this.updatedAt,});

  DataResponse.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    verifyCodeSendAt = json['verify_code_send_at'];
    verifyCodeSendCount = json['verify_code_send_count'];
    verifyCode = json['verify_code'];
    verifyAttemptCount = json['verify_attempt_count'];
    lastVerifyAttemptAt = json['last_verify_attempt_at'];
    phoneVerifiedAt = json['phone_verified_at'];
    imagePath = json['image_path'];
    imageName = json['image_name'];
    imageLocation = json['image_location'];
    role = json['role'];
    isBan = json['isBan'];
    isEditor = json['isEditor'];
    isAdmin = json['isAdmin'];
    parentId = json['parent_id'];
    referCode = json['refer_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? name;
  String? username;
  String? email;
  String? emailVerifiedAt;
  String? phone;
  dynamic verifyCodeSendAt;
  int? verifyCodeSendCount;
  dynamic verifyCode;
  int? verifyAttemptCount;
  dynamic lastVerifyAttemptAt;
  dynamic phoneVerifiedAt;
  String? imagePath;
  String? imageName;
  String? imageLocation;
  String? role;
  String? isBan;
  String? isEditor;
  String? isAdmin;
  int? parentId;
  String? referCode;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['username'] = username;
    map['email'] = email;
    map['email_verified_at'] = emailVerifiedAt;
    map['phone'] = phone;
    map['verify_code_send_at'] = verifyCodeSendAt;
    map['verify_code_send_count'] = verifyCodeSendCount;
    map['verify_code'] = verifyCode;
    map['verify_attempt_count'] = verifyAttemptCount;
    map['last_verify_attempt_at'] = lastVerifyAttemptAt;
    map['phone_verified_at'] = phoneVerifiedAt;
    map['image_path'] = imagePath;
    map['image_name'] = imageName;
    map['image_location'] = imageLocation;
    map['role'] = role;
    map['isBan'] = isBan;
    map['isEditor'] = isEditor;
    map['isAdmin'] = isAdmin;
    map['parent_id'] = parentId;
    map['refer_code'] = referCode;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}