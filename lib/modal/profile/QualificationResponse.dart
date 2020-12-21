class QualificationResponse {
  bool success;
  String message;
  QualificationData qualificationData;

  QualificationResponse(this.success, this.message, this.qualificationData);

  QualificationResponse.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    qualificationData = QualificationData.fromJson(json['qualification']);
  }

  QualificationResponse.fromError(String errorValue) {
    this.message = errorValue;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
  }
}

class QualificationData{
  String user_id;
  String degree;
  String university;
  String image;
  int passing_year;
  int created;
  int updated;

  QualificationData(this.user_id, this.degree, this.university, this.image, this.passing_year, this.created, this.updated);

  QualificationData.fromJson(Map<String, dynamic> json){
    user_id = json['user_id'];
    degree = json['degree'];
    university = json['university'];
    image = json['image'];
    passing_year = json['passing_year'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = user_id;
    data['degree'] = degree;
    data['university'] = university;
    data['image'] = image;
    data['passing_year'] = passing_year;
    data['created'] = created;
    data['updated'] = updated;
    return data;
}
}