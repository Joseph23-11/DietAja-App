class ResponseResultDailySportModel {
  bool? success;
  String? message;
  List<DailySportModel>? data;

  ResponseResultDailySportModel({this.success, this.message, this.data});

  ResponseResultDailySportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DailySportModel>[];
      json['data'].forEach((v) {
        data!.add(DailySportModel.fromJson(v));
      });
    }
  }
}

class DailySportModel {
  int? id;
  String? userId;
  String? sportId;
  String? durasi;
  double? kalori;
  String? createdAt;
  String? updatedAt;
  String? namaOlahraga;

  DailySportModel(
      {this.id,
      this.userId,
      this.sportId,
      this.durasi,
      this.kalori,
      this.createdAt,
      this.updatedAt,
      this.namaOlahraga});

  DailySportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sportId = json['sport_id'];
    durasi = json['durasi'];
    kalori = double.parse(json['kalori'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    namaOlahraga = json['nama_olahraga'];
  }
}
