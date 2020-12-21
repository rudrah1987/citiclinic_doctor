class AddAppointmentScheduleResponse{
  bool success;
  String message;

  AddAppointmentScheduleResponse(this.success, this.message);

  AddAppointmentScheduleResponse.fromJson(Map<String, dynamic> json){
    success = json['success'] == null ? null : json['success'];
    message = json['message'] == null ? null : json['message'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
  }

  AddAppointmentScheduleResponse.fromError(String error){
    message = error;
  }
}