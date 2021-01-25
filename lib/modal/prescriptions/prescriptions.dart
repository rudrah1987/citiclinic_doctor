class PrescriptionsResponse {
  bool success;
  String message;
  Data data;

  PrescriptionsResponse({this.success, this.message, this.data});
  PrescriptionsResponse.fromError(String error) {
    message = error;
  }
  PrescriptionsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<PrescriptionList> prescriptionList;

  Data({this.prescriptionList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['prescription_list'] != null) {
      prescriptionList = new List<PrescriptionList>();
      json['prescription_list'].forEach((v) {
        prescriptionList.add(new PrescriptionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.prescriptionList != null) {
      data['prescription_list'] =
          this.prescriptionList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PrescriptionList {
  Doctor doctor;
  Patient patient;
  OtherPrescriptionDeatils otherPrescriptionDeatils;

  PrescriptionList({this.doctor, this.patient, this.otherPrescriptionDeatils});

  PrescriptionList.fromJson(Map<String, dynamic> json) {
    doctor =
    json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    patient =
    json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    otherPrescriptionDeatils = json['other_prescription_deatils'] != null
        ? new OtherPrescriptionDeatils.fromJson(
        json['other_prescription_deatils'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctor != null) {
      data['doctor'] = this.doctor.toJson();
    }
    if (this.patient != null) {
      data['patient'] = this.patient.toJson();
    }
    if (this.otherPrescriptionDeatils != null) {
      data['other_prescription_deatils'] =
          this.otherPrescriptionDeatils.toJson();
    }
    return data;
  }
}

class Doctor {
  int userId;
  String name;
  String phoneNumber;
  String email;
  String gender;
  String dob;
  String locality;
  String country;
  String state;
  String city;
  String address1;
  String address2;
  String doctorQulifications;
  String registrationDeatils;
  String userBanks;
  String doctorSpecialities;
  String osType;
  String accessToken;
  String profileImage;

  Doctor(
      {this.userId,
        this.name,
        this.phoneNumber,
        this.email,
        this.gender,
        this.dob,
        this.locality,
        this.country,
        this.state,
        this.city,
        this.address1,
        this.address2,
        this.doctorQulifications,
        this.registrationDeatils,
        this.userBanks,
        this.doctorSpecialities,
        this.osType,
        this.accessToken,
        this.profileImage});

  Doctor.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    gender = json['gender'];
    dob = json['dob'];
    locality = json['locality'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    doctorQulifications = json['DoctorQulifications'];
    registrationDeatils = json['RegistrationDeatils'];
    userBanks = json['UserBanks'];
    doctorSpecialities = json['DoctorSpecialities'];
    osType = json['osType'];
    accessToken = json['accessToken'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['locality'] = this.locality;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['DoctorQulifications'] = this.doctorQulifications;
    data['RegistrationDeatils'] = this.registrationDeatils;
    data['UserBanks'] = this.userBanks;
    data['DoctorSpecialities'] = this.doctorSpecialities;
    data['osType'] = this.osType;
    data['accessToken'] = this.accessToken;
    data['profile_image'] = this.profileImage;
    return data;
  }
}

class Patient {
  int userId;
  String name;
  String phoneNumber;
  String email;
  String gender;
  String dob;
  String locality;
  String country;
  String state;
  String city;
  String address1;
  String address2;
  String height;
  String weight;
  String osType;
  String accessToken;
  String profileImage;

  Patient(
      {this.userId,
        this.name,
        this.phoneNumber,
        this.email,
        this.gender,
        this.dob,
        this.locality,
        this.country,
        this.state,
        this.city,
        this.address1,
        this.address2,
        this.height,
        this.weight,
        this.osType,
        this.accessToken,
        this.profileImage});

  Patient.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    gender = json['gender'];
    dob = json['dob'];
    locality = json['locality'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    height = json['height'];
    weight = json['weight'];
    osType = json['osType'];
    accessToken = json['accessToken'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['locality'] = this.locality;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['osType'] = this.osType;
    data['accessToken'] = this.accessToken;
    data['profile_image'] = this.profileImage;
    return data;
  }
}

class OtherPrescriptionDeatils {
  int prescriptionId;
  String medicines;
  String message;
  String image;
  String created;

  OtherPrescriptionDeatils(
      {this.prescriptionId,
        this.medicines,
        this.message,
        this.image,
        this.created});

  OtherPrescriptionDeatils.fromJson(Map<String, dynamic> json) {
    prescriptionId = json['prescription_id'];
    medicines = json['medicines'];
    message = json['message'];
    image = json['image'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prescription_id'] = this.prescriptionId;
    data['medicines'] = this.medicines;
    data['message'] = this.message;
    data['image'] = this.image;
    data['created'] = this.created;
    return data;
  }
}