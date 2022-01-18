class UserDetailResponse {
  bool success;
  String message;
  UserData user;
  UserDetailResponse({this.success, this.message, this.user});
  
  UserDetailResponse.fromError(String errorValue,bool success) {
    this.success=success;
    this.message = errorValue;
  }
  UserDetailResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    user = json['data'] != null ? new UserData.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.user != null) {
      data['data'] = this.user.toJson();
    }
    return data;
  }
}
class UserData {
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
  String quickId;
  String quickLogin;
  String quickPassword;
  DoctorQulifications doctorQulifications;
  RegistrationDeatils registrationDeatils;
  UserBanks userBanks;
  String doctorSpecialities;
  String osType;
  String accessToken;
  String profileImage;
  UserData(
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
      this.quickId,
      this.quickLogin,
      this.quickPassword,
      this.doctorQulifications,
      this.registrationDeatils,
      this.userBanks,
      this.doctorSpecialities,
      this.osType,
      this.accessToken,
      this.profileImage});

  UserData.fromJson(Map<String, dynamic> json) {
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
    quickId = json['quick_id'];
    quickLogin = json['quick_login'];
    quickPassword = json['quick_password'];
    doctorQulifications = json['DoctorQulifications'] != null
        ? new DoctorQulifications.fromJson(json['DoctorQulifications'])
        : null;
    registrationDeatils = json['RegistrationDeatils'] != null
        ? new RegistrationDeatils.fromJson(json['RegistrationDeatils'])
        : null;
    userBanks = json['UserBanks'] != null
        ? new UserBanks.fromJson(json['UserBanks'])
        : null;
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
    data['quick_id'] = this.quickId;
    data['quick_login'] = this.quickLogin;
    data['quick_password'] = this.quickPassword;
    if (this.doctorQulifications != null) {
      data['DoctorQulifications'] = this.doctorQulifications.toJson();
    }
    if (this.registrationDeatils != null) {
      data['RegistrationDeatils'] = this.registrationDeatils.toJson();
    }
    if (this.userBanks != null) {
      data['UserBanks'] = this.userBanks.toJson();
    }
    data['DoctorSpecialities'] = this.doctorSpecialities;
    data['osType'] = this.osType;
    data['accessToken'] = this.accessToken;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
class DoctorQulifications {
  int id;
  int userId;
  String degree;
  String university;
  String passingYear;
  String documentFile;
  String created;
  String modified;
  DoctorQulifications(
      {this.id,
        this.userId,
        this.degree,
        this.university,
        this.passingYear,
        this.documentFile,
        this.created,
        this.modified});
  DoctorQulifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    degree = json['degree'];
    university = json['university'];
    passingYear = json['passing_year'];
    documentFile = json['document_file'];
    created = json['created'];
    modified = json['modified'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['degree'] = this.degree;
    data['university'] = this.university;
    data['passing_year'] = this.passingYear;
    data['document_file'] = this.documentFile;
    data['created'] = this.created;
    data['modified'] = this.modified;
    return data;
  }
}
class RegistrationDeatils {
  int id;
  int userId;
  String registrationNumber;
  String registrationCouncil;
  String registrationDate;
  String documentFile;
  String created;
  String modified;
  RegistrationDeatils(
      {this.id,
        this.userId,
        this.registrationNumber,
        this.registrationCouncil,
        this.registrationDate,
        this.documentFile,
        this.created,
        this.modified});
  RegistrationDeatils.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    registrationNumber = json['registration_number'];
    registrationCouncil = json['registration_council'];
    registrationDate = json['registration_date'];
    documentFile = json['document_file'];
    created = json['created'];
    modified = json['modified'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['registration_number'] = this.registrationNumber;
    data['registration_council'] = this.registrationCouncil;
    data['registration_date'] = this.registrationDate;
    data['document_file'] = this.documentFile;
    data['created'] = this.created;
    data['modified'] = this.modified;
    return data;
  }
}
class UserBanks {
  int id;
  int userId;
  String bankName;
  String accountHolderName;
  String accountNumber;
  String ifscCode;
  String created;
  String modified;
  UserBanks(
      {this.id,
        this.userId,
        this.bankName,
        this.accountHolderName,
        this.accountNumber,
        this.ifscCode,
        this.created,
        this.modified});
  UserBanks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bankName = json['bank_name'];
    accountHolderName = json['account_holder_name'];
    accountNumber = json['account_number'];
    ifscCode = json['ifsc_code'];
    created = json['created'];
    modified = json['modified'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['bank_name'] = this.bankName;
    data['account_holder_name'] = this.accountHolderName;
    data['account_number'] = this.accountNumber;
    data['ifsc_code'] = this.ifscCode;
    data['created'] = this.created;
    data['modified'] = this.modified;
    return data;
  }
}


// Send a message to Tushar Dubey
