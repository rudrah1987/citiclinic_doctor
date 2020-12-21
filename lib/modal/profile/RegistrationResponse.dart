class RegistrationResponse {
  bool success;
  String message;

  RegistrationResponse(this.success, this.message);

  RegistrationResponse.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
  }

  RegistrationResponse.fromError(String errorValue) {
    this.message = errorValue;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
  }
}