class Errors {
  Errors({
      this.newPassword, 
      this.newPasswordConfirm,});

  Errors.fromJson(dynamic json) {
    newPassword = json['new_password'] != null ? json['new_password'].cast<String>() : [];
    newPasswordConfirm = json['new_password_confirm'] != null ? json['new_password_confirm'].cast<String>() : [];
  }
  List<String>? newPassword;
  List<String>? newPasswordConfirm;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['new_password'] = newPassword;
    map['new_password_confirm'] = newPasswordConfirm;
    return map;
  }

}