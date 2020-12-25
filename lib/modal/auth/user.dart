class User {
  int user_id;
  String name, phone_number, email, dob, gender, experience;
  String hospital_address, land_mark, availability_for_home_visit;
  String consultation_type, country, state, city, profile_image;
  String accessToken, appVersion, latitude, longitude,osType;
  bool isLoggedIn=false;

  User(
      {this.user_id, this.name, this.phone_number, this.email,
        this.dob, this.gender, this.experience,this.hospital_address,
        this.land_mark, this.availability_for_home_visit, this.consultation_type,
        this.city, this.state, this.country, this.profile_image,
        this.accessToken, this.appVersion, this.longitude, this.latitude, this.osType,this.isLoggedIn});

  User.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'] == null ? null : json['user_id'];
    email = json['email'] == null ? null : json['email'];
    phone_number = json['phone_number'] == null ? null : json['phone_number'];
    name = json['name'] == null ? null : json['name'];
    dob = json['dob'] == null ? null : json['dob'];
    gender = json['gender'] == null ? null : json['gender'];
    experience = json['experience'] == null ? null : json['experience'];
    hospital_address = json['hospital_address'] == null ? null : json['hospital_address'];
    land_mark = json['land_mark'] == null ? null : json['land_mark'];
    availability_for_home_visit = json['availability_for_home_visit'] == null ? null : json['availability_for_home_visit'];
    consultation_type = json['consultation_type'] == null ? null : json['consultation_type'];
    country = json['country'] == null ? null : json['country'];
    state = json['state'] == null ? null : json['state'];
    city = json['city'] == null ? null : json['city'];
    profile_image = json['profile_image'] == null ? null : json['profile_image'];
    accessToken = json['accessToken'] == null ? null : json['accessToken'];
    latitude = json['latitude'] == null ? null : json['latitude'];
    longitude = json['longitude'] == null ? null : json['longitude'];
    appVersion = json['appVersion'] == null ? null : json['appVersion'];
    osType = json['osType'] == null ? null : json['osType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.user_id == null ? null : user_id;
    data['email'] = this.email == null ? null : email;
    data['phone_number'] = this.phone_number == null ? null : phone_number;
    data['name'] = this.name == null ? null : name;
    data['dob'] = this.dob == null ? null : dob;
    data['gender'] = this.gender == null ? null : gender;
    data['experience'] = this.experience == null ? null : experience;
    data['hospital_address'] = this.hospital_address == null ? null : hospital_address;
    data['land_mark'] = this.land_mark == null ? null : land_mark;
    data['availability_for_home_visit'] = this.availability_for_home_visit == null ? null : availability_for_home_visit;
    data['consultation_type'] = this.consultation_type == null ? null : consultation_type;
    data['country'] = this.country == null ? null : country;
    data['state'] = this.state == null ? null : state;
    data['city'] = this.city == null ? null : city;
    data['profile_image'] = this.profile_image == null ? null : profile_image;
    data['accessToken'] = this.accessToken == null ? null : accessToken;
    data['latitude'] = this.latitude == null ? null : latitude;
    data['longitude'] = this.longitude == null ? null : longitude;
    data['appVersion'] = this.appVersion == null ? null : appVersion;
    data['osType'] = this.osType == null ? null : osType;
    return data;
  }
}