class CityResponse{
  bool success;
  String message;
  List<CityData> cityList;

  CityResponse(this.success, this.message, this.cityList);

  CityResponse.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    cityList = (json['city_list'] as List).map((i) => CityData.fromJson(i)).toList();
  }

  CityResponse.fromError(String errorValue) {
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

class CityData{
  int id;
  String name;
  int state_id;

  CityData(this.id, this.name, this.state_id);

  CityData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    state_id = json['state_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['state_id'] = state_id;
  }
}