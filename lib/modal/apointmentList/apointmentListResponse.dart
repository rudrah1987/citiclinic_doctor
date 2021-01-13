class AppointmentListResponse {
  bool success;
  String message;
  List<Data> data;

  AppointmentListResponse({this.success, this.message, this.data});

  AppointmentListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }
  AppointmentListResponse.fromError(String error){
    message = error;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  int doctorId;
  int bookBy;
  int patientId;
  int amount;
  String datetimeStart;
  String datetimeEnd;
  String visitType;
  String country;
  String state;
  String city;
  String address1;
  String address2;
  String pinCode;
  String created;
  String modified;
  int statusId;

  Data(
      {this.id,
      this.doctorId,
      this.bookBy,
      this.patientId,
      this.amount,
      this.datetimeStart,
      this.datetimeEnd,
      this.visitType,
      this.country,
      this.state,
      this.city,
      this.address1,
      this.address2,
      this.pinCode,
      this.created,
      this.modified,
      this.statusId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    bookBy = json['book_by'];
    patientId = json['patient_id'];
    amount = json['amount'];
    datetimeStart = json['datetime_start'];
    datetimeEnd = json['datetime_end'];
    visitType = json['visit_type'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    pinCode = json['pin_code'];
    created = json['created'];
    modified = json['modified'];
    statusId = json['status_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_id'] = this.doctorId;
    data['book_by'] = this.bookBy;
    data['patient_id'] = this.patientId;
    data['amount'] = this.amount;
    data['datetime_start'] = this.datetimeStart;
    data['datetime_end'] = this.datetimeEnd;
    data['visit_type'] = this.visitType;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['pin_code'] = this.pinCode;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['status_id'] = this.statusId;
    return data;
  }
}
