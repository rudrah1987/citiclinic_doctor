import 'package:city_clinic_doctor/modal/auth/user.dart';

class ChangePassResponse {
  bool success;
  String message;
  User user;

  ChangePassResponse(this.success, this.message, this.user);

  ChangePassResponse.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    this.user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
  }

  ChangePassResponse.fromError(String error){
    message = error;
  }
}