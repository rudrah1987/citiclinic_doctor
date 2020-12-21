import 'package:city_clinic_doctor/modal/auth/user.dart';

class ResetPassResponse {
  bool success;
  String message;

  ResetPassResponse(this.success, this.message);

  ResetPassResponse.fromJson(Map<String, dynamic> json) {
    this.success = json['success'];
    this.message = json['message'];
  }

  ResetPassResponse.fromError(String errorValue/*, int errorCode*/) {
    this.message = errorValue;
  }
}