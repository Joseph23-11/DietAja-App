class ResponseResultPersonalDetailModel {
  bool? success;
  PersonalDetailModel? data;

  ResponseResultPersonalDetailModel({this.success, this.data});

  ResponseResultPersonalDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? PersonalDetailModel.fromJson(json['data'])
        : null;
  }
}

class PersonalDetailModel {
  int? id;
  String? userId;
  String? jenisKelamin;
  String? beratBadan;
  String? tinggiBadan;
  String? usia;
  String? createdAt;
  String? updatedAt;

  PersonalDetailModel({
    this.id,
    this.userId,
    this.jenisKelamin,
    this.beratBadan,
    this.tinggiBadan,
    this.usia,
    this.createdAt,
    this.updatedAt,
  });

  PersonalDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    jenisKelamin = json['jenis_kelamin'];
    beratBadan = json['berat_badan'];
    tinggiBadan = json['tinggi_badan'];
    usia = json['usia'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
