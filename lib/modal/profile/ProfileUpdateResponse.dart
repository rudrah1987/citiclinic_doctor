import 'package:city_clinic_doctor/modal/auth/user.dart';

class ProfileUpdateResponse {
  bool success;
  String message;
  User user;

  ProfileUpdateResponse(this.success, this.message, this.user);

  ProfileUpdateResponse.fromJson(Map<String, dynamic> json) {
    this.success = json['success'];
    this.message = json['message'];
    this.user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  ProfileUpdateResponse.fromError(String errorValue/*, int errorCode*/) {
    this.message = errorValue;
    // this.errorCode = errorCode;
  }
}