class ResponseResultUserModel {
  bool? success;
  UserModel? data;

  ResponseResultUserModel({this.success, this.data});

  ResponseResultUserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? UserModel.fromJson(json['data']) : null;
  }
}

class UserModel {
  int? id;
  String? username;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.username,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
