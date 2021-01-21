class NotificationsResponse {
  bool success;
  String message;
  List<Data> data;

  NotificationsResponse({this.success, this.message, this.data});
  NotificationsResponse.fromError(String error){
    message = error;
  }
  NotificationsResponse.fromJson(Map<String, dynamic> json) {
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
  int offerId;
  String title;
  String userId;
  String description;
  String image;
  String tag;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
        this.offerId,
        this.title,
        this.userId,
        this.description,
        this.image,
        this.tag,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offerId = json['offer_id'];
    title = json['title'];
    userId = json['user_id'];
    description = json['description'];
    image = json['image'];
    tag = json['tag'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['offer_id'] = this.offerId;
    data['title'] = this.title;
    data['user_id'] = this.userId;
    data['description'] = this.description;
    data['image'] = this.image;
    data['tag'] = this.tag;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}