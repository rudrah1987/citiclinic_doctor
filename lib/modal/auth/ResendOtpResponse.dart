class ResendOtpResponse {
  bool success;
  String message;
  OtpData otpData;

  ResendOtpResponse(this.success, this.message, this.otpData);

  ResendOtpResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    otpData = json['otp'] != null ? new OtpData.fromJson(json['otp']) : null;
  }

  ResendOtpResponse.fromError(String errorValue/*, int errorCode*/) {
    this.message = errorValue;
    // this.errorCode = errorCode;
  }
}

class OtpData{
  String otp;

  OtpData(this.otp);

  OtpData.fromJson(Map<String, dynamic> json){
    otp = json['otp'];
  }
}