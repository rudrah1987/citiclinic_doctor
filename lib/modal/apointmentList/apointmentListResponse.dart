class AppointmentListResponse {
  bool success;
  String message;
  Data data;
  AppointmentListResponse.fromError(String error) {
    message = error;
  }
  AppointmentListResponse({this.success, this.message, this.data});

  AppointmentListResponse.fromJson(Map<String, dynamic> json) {
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
  List<BookingList> bookingList;

  Data({this.bookingList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['booking_list'] != null) {
      bookingList = new List<BookingList>();
      json['booking_list'].forEach((v) {
        bookingList.add(new BookingList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookingList != null) {
      data['booking_list'] = this.bookingList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingList {
  Doctor doctor;
  BookBy bookBy;
  Patient patient;
  OtherBookingDeatils otherBookingDeatils;

  BookingList(
      {this.doctor, this.bookBy, this.patient, this.otherBookingDeatils});

  BookingList.fromJson(Map<String, dynamic> json) {
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    bookBy =
        json['book_by'] != null ? new BookBy.fromJson(json['book_by']) : null;
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    otherBookingDeatils = json['other_booking_deatils'] != null
        ? new OtherBookingDeatils.fromJson(json['other_booking_deatils'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctor != null) {
      data['doctor'] = this.doctor.toJson();
    }
    if (this.bookBy != null) {
      data['book_by'] = this.bookBy.toJson();
    }
    if (this.patient != null) {
      data['patient'] = this.patient.toJson();
    }
    if (this.otherBookingDeatils != null) {
      data['other_booking_deatils'] = this.otherBookingDeatils.toJson();
    }
    return data;
  }
}

class Doctor {
  int id;
  String parentId;
  String relationId;
  int roleId;
  String name;
  String phoneNumber;
  String email;
  String gender;
  String dob;
  String exprience;
  String description;
  String hospitalName;
  String hospitalAddress;
  String countryId;
  String nationalityId;
  String stateId;
  String cityId;
  String address1;
  String address2;
  String locality;
  String height;
  String weight;
  String landMark;
  String availabilityForHomeVisit;
  String profileImage;
  String coverProfileImage;
  String passCivilNumber;
  String password;
  String otp;
  String consultationType;
  String consultationFees;
  String status;
  String webShow;
  String longitude;
  String latitude;
  String accessToken;
  String appVersion;
  String fcmToken;
  String osType;
  Null firebaseToken;
  String quickId;
  String quickLogin;
  String quickPassword;
  String created;
  String modified;

  Doctor(
      {this.id,
      this.parentId,
      this.relationId,
      this.roleId,
      this.name,
      this.phoneNumber,
      this.email,
      this.gender,
      this.dob,
      this.exprience,
      this.description,
      this.hospitalName,
      this.hospitalAddress,
      this.countryId,
      this.nationalityId,
      this.stateId,
      this.cityId,
      this.address1,
      this.address2,
      this.locality,
      this.height,
      this.weight,
      this.landMark,
      this.availabilityForHomeVisit,
      this.profileImage,
      this.coverProfileImage,
      this.passCivilNumber,
      this.password,
      this.otp,
      this.consultationType,
      this.consultationFees,
      this.status,
      this.webShow,
      this.longitude,
      this.latitude,
      this.accessToken,
      this.appVersion,
      this.fcmToken,
      this.osType,
      this.firebaseToken,
      this.quickId,
      this.quickLogin,
      this.quickPassword,
      this.created,
      this.modified});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    relationId = json['relation_id'];
    roleId = json['role_id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    gender = json['gender'];
    dob = json['dob'];
    exprience = json['exprience'];
    description = json['description'];
    hospitalName = json['hospital_name'];
    hospitalAddress = json['hospital_address'];
    countryId = json['country_id'];
    nationalityId = json['nationality_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    locality = json['locality'];
    height = json['height'];
    weight = json['weight'];
    landMark = json['land_mark'];
    availabilityForHomeVisit = json['availability_for_home_visit'];
    profileImage = json['profile_image'];
    coverProfileImage = json['cover_profile_image'];
    passCivilNumber = json['pass_civil_number'];
    password = json['password'];
    otp = json['otp'];
    consultationType = json['consultation_type'];
    consultationFees = json['consultation_fees'];
    status = json['status'];
    webShow = json['web_show'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    accessToken = json['access_token'];
    appVersion = json['app_version'];
    fcmToken = json['fcmToken'];
    osType = json['os_type'];
    firebaseToken = json['firebase_token'];
    quickId = json['quick_id'];
    quickLogin = json['quick_login'];
    quickPassword = json['quick_password'];
    created = json['created'];
    modified = json['modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['relation_id'] = this.relationId;
    data['role_id'] = this.roleId;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['exprience'] = this.exprience;
    data['description'] = this.description;
    data['hospital_name'] = this.hospitalName;
    data['hospital_address'] = this.hospitalAddress;
    data['country_id'] = this.countryId;
    data['nationality_id'] = this.nationalityId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['locality'] = this.locality;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['land_mark'] = this.landMark;
    data['availability_for_home_visit'] = this.availabilityForHomeVisit;
    data['profile_image'] = this.profileImage;
    data['cover_profile_image'] = this.coverProfileImage;
    data['pass_civil_number'] = this.passCivilNumber;
    data['password'] = this.password;
    data['otp'] = this.otp;
    data['consultation_type'] = this.consultationType;
    data['consultation_fees'] = this.consultationFees;
    data['status'] = this.status;
    data['web_show'] = this.webShow;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['access_token'] = this.accessToken;
    data['app_version'] = this.appVersion;
    data['fcmToken'] = this.fcmToken;
    data['os_type'] = this.osType;
    data['firebase_token'] = this.firebaseToken;
    data['quick_id'] = this.quickId;
    data['quick_login'] = this.quickLogin;
    data['quick_password'] = this.quickPassword;
    data['created'] = this.created;
    data['modified'] = this.modified;
    return data;
  }
}

class BookBy {
  int id;
  Null parentId;
  Null relationId;
  int roleId;
  String name;
  String phoneNumber;
  String email;
  String gender;
  String dob;
  String exprience;
  String description;
  String hospitalName;
  String hospitalAddress;
  String countryId;
  String nationalityId;
  String stateId;
  String cityId;
  String address1;
  String address2;
  String locality;
  String height;
  String weight;
  String landMark;
  String availabilityForHomeVisit;
  String profileImage;
  String coverProfileImage;
  String passCivilNumber;
  String password;
  String otp;
  String consultationType;
  String consultationFees;
  String status;
  String webShow;
  String longitude;
  String latitude;
  String accessToken;
  String appVersion;
  String fcmToken;
  String osType;
  String firebaseToken;
  String quickId;
  String quickLogin;
  String quickPassword;
  String created;
  String modified;

  BookBy(
      {this.id,
      this.parentId,
      this.relationId,
      this.roleId,
      this.name,
      this.phoneNumber,
      this.email,
      this.gender,
      this.dob,
      this.exprience,
      this.description,
      this.hospitalName,
      this.hospitalAddress,
      this.countryId,
      this.nationalityId,
      this.stateId,
      this.cityId,
      this.address1,
      this.address2,
      this.locality,
      this.height,
      this.weight,
      this.landMark,
      this.availabilityForHomeVisit,
      this.profileImage,
      this.coverProfileImage,
      this.passCivilNumber,
      this.password,
      this.otp,
      this.consultationType,
      this.consultationFees,
      this.status,
      this.webShow,
      this.longitude,
      this.latitude,
      this.accessToken,
      this.appVersion,
      this.fcmToken,
      this.osType,
      this.firebaseToken,
      this.quickId,
      this.quickLogin,
      this.quickPassword,
      this.created,
      this.modified});

  BookBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    relationId = json['relation_id'];
    roleId = json['role_id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    gender = json['gender'];
    dob = json['dob'];
    exprience = json['exprience'];
    description = json['description'];
    hospitalName = json['hospital_name'];
    hospitalAddress = json['hospital_address'];
    countryId = json['country_id'];
    nationalityId = json['nationality_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    locality = json['locality'];
    height = json['height'];
    weight = json['weight'];
    landMark = json['land_mark'];
    availabilityForHomeVisit = json['availability_for_home_visit'];
    profileImage = json['profile_image'];
    coverProfileImage = json['cover_profile_image'];
    passCivilNumber = json['pass_civil_number'];
    password = json['password'];
    otp = json['otp'];
    consultationType = json['consultation_type'];
    consultationFees = json['consultation_fees'];
    status = json['status'];
    webShow = json['web_show'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    accessToken = json['access_token'];
    appVersion = json['app_version'];
    fcmToken = json['fcmToken'];
    osType = json['os_type'];
    firebaseToken = json['firebase_token'];
    quickId = json['quick_id'];
    quickLogin = json['quick_login'];
    quickPassword = json['quick_password'];
    created = json['created'];
    modified = json['modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['relation_id'] = this.relationId;
    data['role_id'] = this.roleId;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['exprience'] = this.exprience;
    data['description'] = this.description;
    data['hospital_name'] = this.hospitalName;
    data['hospital_address'] = this.hospitalAddress;
    data['country_id'] = this.countryId;
    data['nationality_id'] = this.nationalityId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['locality'] = this.locality;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['land_mark'] = this.landMark;
    data['availability_for_home_visit'] = this.availabilityForHomeVisit;
    data['profile_image'] = this.profileImage;
    data['cover_profile_image'] = this.coverProfileImage;
    data['pass_civil_number'] = this.passCivilNumber;
    data['password'] = this.password;
    data['otp'] = this.otp;
    data['consultation_type'] = this.consultationType;
    data['consultation_fees'] = this.consultationFees;
    data['status'] = this.status;
    data['web_show'] = this.webShow;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['access_token'] = this.accessToken;
    data['app_version'] = this.appVersion;
    data['fcmToken'] = this.fcmToken;
    data['os_type'] = this.osType;
    data['firebase_token'] = this.firebaseToken;
    data['quick_id'] = this.quickId;
    data['quick_login'] = this.quickLogin;
    data['quick_password'] = this.quickPassword;
    data['created'] = this.created;
    data['modified'] = this.modified;
    return data;
  }
}

class Patient {
  int id;
  int parentId;
  int relationId;
  int roleId;
  String name;
  String phoneNumber;
  String email;
  String gender;
  String dob;
  String exprience;
  String description;
  String hospitalName;
  String hospitalAddress;
  String countryId;
  String nationalityId;
  String stateId;
  String cityId;
  String address1;
  String address2;
  String locality;
  String height;
  String weight;
  String landMark;
  String availabilityForHomeVisit;
  String profileImage;
  String coverProfileImage;
  String passCivilNumber;
  String password;
  String otp;
  String consultationType;
  Null consultationFees;
  String status;
  String webShow;
  String longitude;
  String latitude;
  String accessToken;
  String appVersion;
  String fcmToken;
  String osType;
  String firebaseToken;
  String quickId;
  String quickLogin;
  String quickPassword;
  String created;
  String modified;

  Patient(
      {this.id,
      this.parentId,
      this.relationId,
      this.roleId,
      this.name,
      this.phoneNumber,
      this.email,
      this.gender,
      this.dob,
      this.exprience,
      this.description,
      this.hospitalName,
      this.hospitalAddress,
      this.countryId,
      this.nationalityId,
      this.stateId,
      this.cityId,
      this.address1,
      this.address2,
      this.locality,
      this.height,
      this.weight,
      this.landMark,
      this.availabilityForHomeVisit,
      this.profileImage,
      this.coverProfileImage,
      this.passCivilNumber,
      this.password,
      this.otp,
      this.consultationType,
      this.consultationFees,
      this.status,
      this.webShow,
      this.longitude,
      this.latitude,
      this.accessToken,
      this.appVersion,
      this.fcmToken,
      this.osType,
      this.firebaseToken,
      this.quickId,
      this.quickLogin,
      this.quickPassword,
      this.created,
      this.modified});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    relationId = json['relation_id'];
    roleId = json['role_id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    gender = json['gender'];
    dob = json['dob'];
    exprience = json['exprience'];
    description = json['description'];
    hospitalName = json['hospital_name'];
    hospitalAddress = json['hospital_address'];
    countryId = json['country_id'];
    nationalityId = json['nationality_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    locality = json['locality'];
    height = json['height'];
    weight = json['weight'];
    landMark = json['land_mark'];
    availabilityForHomeVisit = json['availability_for_home_visit'];
    profileImage = json['profile_image'];
    coverProfileImage = json['cover_profile_image'];
    passCivilNumber = json['pass_civil_number'];
    password = json['password'];
    otp = json['otp'];
    consultationType = json['consultation_type'];
    consultationFees = json['consultation_fees'];
    status = json['status'];
    webShow = json['web_show'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    accessToken = json['access_token'];
    appVersion = json['app_version'];
    fcmToken = json['fcmToken'];
    osType = json['os_type'];
    firebaseToken = json['firebase_token'];
    quickId = json['quick_id'];
    quickLogin = json['quick_login'];
    quickPassword = json['quick_password'];
    created = json['created'];
    modified = json['modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['relation_id'] = this.relationId;
    data['role_id'] = this.roleId;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['exprience'] = this.exprience;
    data['description'] = this.description;
    data['hospital_name'] = this.hospitalName;
    data['hospital_address'] = this.hospitalAddress;
    data['country_id'] = this.countryId;
    data['nationality_id'] = this.nationalityId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['locality'] = this.locality;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['land_mark'] = this.landMark;
    data['availability_for_home_visit'] = this.availabilityForHomeVisit;
    data['profile_image'] = this.profileImage;
    data['cover_profile_image'] = this.coverProfileImage;
    data['pass_civil_number'] = this.passCivilNumber;
    data['password'] = this.password;
    data['otp'] = this.otp;
    data['consultation_type'] = this.consultationType;
    data['consultation_fees'] = this.consultationFees;
    data['status'] = this.status;
    data['web_show'] = this.webShow;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['access_token'] = this.accessToken;
    data['app_version'] = this.appVersion;
    data['fcmToken'] = this.fcmToken;
    data['os_type'] = this.osType;
    data['firebase_token'] = this.firebaseToken;
    data['quick_id'] = this.quickId;
    data['quick_login'] = this.quickLogin;
    data['quick_password'] = this.quickPassword;
    data['created'] = this.created;
    data['modified'] = this.modified;
    return data;
  }
}

class OtherBookingDeatils {
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
  int bookingStatus;
  String created;

  OtherBookingDeatils(
      {this.amount,
      this.datetimeStart,
      this.datetimeEnd,
      this.visitType,
      this.country,
      this.state,
      this.city,
      this.address1,
      this.address2,
      this.pinCode,
      this.bookingStatus,
      this.created});

  OtherBookingDeatils.fromJson(Map<String, dynamic> json) {
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
    bookingStatus = json['booking_status'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['booking_status'] = this.bookingStatus;
    data['created'] = this.created;
    return data;
  }
}
