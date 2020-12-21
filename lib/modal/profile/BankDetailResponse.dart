class BankDetailResponse{
  bool success;
  String message;
  List<SpecialityData> specialities;

  BankDetailResponse(this.success, this.message, this.specialities);

  BankDetailResponse.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    specialities = (json['specialities'] as List).map((i) => SpecialityData.fromJson(i)).toList();
  }

  BankDetailResponse.fromError(String errorValue) {
    this.message = errorValue;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
  }


}

extension MyIterable<E> on Iterable<E> {
  Iterable<E> sortedBy(Comparable key(E e)) =>
      toList()..sort((a, b) => key(a).compareTo(key(b)));
}

class SpecialityData{
  int id;
  String speciality_type;
  String status;

  SpecialityData(this.id, this.speciality_type, this.status);

  SpecialityData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    speciality_type = json['speciality_type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['speciality_type'] = speciality_type;
    data['status'] = status;
  }
}