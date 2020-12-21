class ProfileImageResponse {
  bool success;
  String message;

  ProfileImageResponse(this.success, this.message);

  ProfileImageResponse.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
  }

  ProfileImageResponse.fromError(String error){
    message = error;
  }
}