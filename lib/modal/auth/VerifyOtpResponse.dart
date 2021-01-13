import 'package:city_clinic_doctor/modal/auth/user.dart';
import 'package:city_clinic_doctor/modal/profile/UserDetailResponse.dart';

class VerifyOtpResponse {
  bool success;
  String message;
  UserData user;

  VerifyOtpResponse(this.success, this.message, this.user);

  VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    this.success = json['success'];
    this.message = json['message'];
    this.user = json['user'] != null ? UserData.fromJson(json['user']) : null;
  }

  VerifyOtpResponse.fromError(String errorValue) {
    this.message = errorValue;
  }
}