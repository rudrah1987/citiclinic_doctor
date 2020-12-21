import 'package:city_clinic_doctor/modal/auth/user.dart';

class VerifyOtpResponse {
  bool success;
  String message;
  User user;

  VerifyOtpResponse(this.success, this.message, this.user);

  VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    this.success = json['success'];
    this.message = json['message'];
    this.user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  VerifyOtpResponse.fromError(String errorValue) {
    this.message = errorValue;
  }
}