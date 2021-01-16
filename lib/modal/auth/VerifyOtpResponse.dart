import 'package:city_clinic_doctor/modal/profile/UserDetailResponse.dart';

class VerifyOtpResponse {
  bool success;
  String message;
  UserData user;

  VerifyOtpResponse({this.success, this.message, this.user});
VerifyOtpResponse.fromError(String errorValue) {
    this.message = errorValue;
  }
  VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    user = json['data'] != null ? new UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.user != null) {
      data['data'] = this.user.toJson();
    }
    return data;
  }
}

