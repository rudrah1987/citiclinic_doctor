
class ForgotPassResponse {
  bool success;
  String message;
  String otp;
  UserForgotData user;

  ForgotPassResponse(this.success, this.message, this.otp, this.user);

  ForgotPassResponse.fromJson(Map<String, dynamic> json) {
    this.success = json['success'] == null ? null : json['success'];
    this.message = json['message'] == null ? null : json['message'];
    this.otp = json['otp'] == null ? null : json['otp'];
    this.user = json['user'] != null ? UserForgotData.fromJson(json['user']) : null;
  }

  ForgotPassResponse.fromError(String errorValue/*, int errorCode*/) {
    this.message = errorValue;
    // this.errorCode = errorCode;
  }
}

class UserForgotData{
  int user_id;
  int result_forgot_log_id;
  String type;
  String otp;
  String phone_number;

  UserForgotData(this.user_id, this.result_forgot_log_id, this.type, this.otp, this.phone_number);

  UserForgotData.fromJson(Map<String, dynamic> json){
    user_id = json['user_id'] == null ? null : json['user_id'];
    result_forgot_log_id = json['result_forgot_log_id'] == null ? null : json['result_forgot_log_id'];
    type = json['type'] == null ? null : json['type'];
    otp = json['otp'] == null ? null : json['otp'];
    phone_number = json['phone_number'] == null ? null : json['phone_number'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = user_id;
    data['result_forgot_log_id'] = result_forgot_log_id;
    data['type'] = type;
    data['otp'] = otp;
    data['phone_number'] = phone_number;
  }
}