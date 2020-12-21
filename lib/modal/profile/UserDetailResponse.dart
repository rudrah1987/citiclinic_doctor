import 'package:city_clinic_doctor/modal/auth/user.dart';

class UserDetailResponse {
  bool success;
  String message;
  User user;

  UserDetailResponse(this.success, this.message, this.user);

  UserDetailResponse.fromJson(Map<String, dynamic> json) {
    this.success = json['success'] == null ? null : json['success'];
    this.message = json['message'] == null ? null : json['message'];
    this.user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  UserDetailResponse.fromError(String errorValue/*, int errorCode*/) {
    this.message = errorValue;
    // this.errorCode = errorCode;
  }
}