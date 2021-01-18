class StaticPageResponse {
  bool success;
  String message;
  List<Data> data;
  
  StaticPageResponse.fromError(String errorValue) {
    this.message = errorValue;
  }
  StaticPageResponse({this.success, this.message, this.data});

  StaticPageResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
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
  String pageName;
  String title;
  String image;
  String description;
  String status;

  Data(
      {this.id,
        this.pageName,
        this.title,
        this.image,
        this.description,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pageName = json['page_name'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['page_name'] = this.pageName;
    data['title'] = this.title;
    data['image'] = this.image;
    data['description'] = this.description;
    data['status'] = this.status;
    return data;
  }
}