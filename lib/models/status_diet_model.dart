class ResponseResultStatusDietModel {
  bool? success;
  String? message;
  StatusDiet? data;

  ResponseResultStatusDietModel({this.success, this.message, this.data});

  ResponseResultStatusDietModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? StatusDiet.fromJson(json['data']) : null;
  }
}

class StatusDiet {
  int? statusHariDiet;

  StatusDiet({this.statusHariDiet});

  StatusDiet.fromJson(Map<String, dynamic> json) {
    statusHariDiet = json['status_hari_diet'];
  }
}
