class CountryResponse{
  bool success;
  String message;
  List<CountryData> countryList;

  CountryResponse(this.success, this.message, this.countryList);

  CountryResponse.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    countryList = (json['country_list'] as List).map((i) => CountryData.fromJson(i)).toList();
  }

  CountryResponse.fromError(String errorValue) {
    this.message = errorValue;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
  }
}

class CountryData{
  int id;
  String name;
  String sortname;

  CountryData(this.id, this.name, this.sortname);

  CountryData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    sortname = json['sortname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['sortname'] = sortname;
  }
}