class SignUpResponse {
  bool success;
  String message;
  String otp;
  UserSignUpData user;

  SignUpResponse(this.success, this.message, this.otp, this.user);

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    this.success = json['success'];
    this.message = json['message'];
    this.otp = json['otp'];
    this.user = json['user'] != null ? new UserSignUpData.fromJson(json['user']) : null;
  }

  SignUpResponse.fromError(String errorValue, int statusCode) {
    this.message = errorValue;
  }
}

class UserSignUpData{
  int user_id;
  int user_log_id;
  String email;
  String otp;
  String phone_number;
  String status = null;

  UserSignUpData(this.user_id, this.user_log_id, this.email, this.otp, this.phone_number, this.status);

  UserSignUpData.fromJson(Map<String, dynamic> json){
    user_id = json['user_id'];
    user_log_id = json['user_log_id'];
    email = json['email'];
    otp = json['otp'];
    phone_number = json['phone_number'];
    status = json['status'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = user_id;
    data['user_log_id'] = user_log_id;
    data['email'] = email;
    data['otp'] = otp;
    data['phone_number'] = phone_number;
    data['status'] = status;
  }
}