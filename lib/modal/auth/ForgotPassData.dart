class ForgotPassData{
  String phone;
  String type;
  String fromPage;

  ForgotPassData(this.phone, this.fromPage, this.type);

  ForgotPassData.fromJson(Map<String, dynamic> json){
    phone = json['phone'];
    type = json['type'];
    fromPage = json['fromPage'];
  }

  Map<String, dynamic> toJson() => {
    'phone': phone,
    'type': type,
    'fromPage': fromPage
  };
}