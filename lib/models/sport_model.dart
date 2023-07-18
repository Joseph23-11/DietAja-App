class ResponseResultSportModel {
  bool? success;
  List<SportModel>? data;

  ResponseResultSportModel({this.success, this.data});

  ResponseResultSportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SportModel>[];
      json['data'].forEach((v) {
        data!.add(SportModel.fromJson(v));
      });
    }
  }
}

class SportModel {
  int? id;
  String? namaOlahraga;
  double? berat;
  double? kalori;
  String? durasi;
  String? createdAt;
  String? updatedAt;

  SportModel({
    this.id,
    this.namaOlahraga,
    this.berat,
    this.kalori,
    this.durasi,
    this.createdAt,
    this.updatedAt,
  });

  SportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaOlahraga = json['nama_olahraga'];
    berat = double.parse(json['berat'].toString());
    kalori = double.parse(json['kalori'].toString());
    durasi = json['durasi'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
