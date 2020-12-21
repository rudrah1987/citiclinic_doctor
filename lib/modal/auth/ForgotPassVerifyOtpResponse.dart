import 'package:city_clinic_doctor/modal/auth/user.dart';

class ForgotPassVerifyOtpResponse {
  bool success;
  String message;
  User user;

  ForgotPassVerifyOtpResponse(this.success, this.message, this.user);

  ForgotPassVerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    this.success = json['success'];
    this.message = json['message'];
    this.user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  ForgotPassVerifyOtpResponse.fromError(String errorValue/*, int errorCode*/) {
    this.message = errorValue;
  }
}