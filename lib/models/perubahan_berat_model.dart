class ResponseResultPerubahanBeratModel {
  List<PerubahanBeratModel>? perubahanBerat;

  ResponseResultPerubahanBeratModel({this.perubahanBerat});

  ResponseResultPerubahanBeratModel.fromJson(Map<String, dynamic> json) {
    if (json['perubahan_berat'] != null) {
      perubahanBerat = <PerubahanBeratModel>[];
      json['perubahan_berat'].forEach((v) {
        perubahanBerat!.add(PerubahanBeratModel.fromJson(v));
      });
    }
  }
}

class PerubahanBeratModel {
  int? id;
  String? personalDetailId;
  double? beratSebelumnya;
  double? beratSekarang;
  double? jumlahPengurangan;
  String? createdAt;
  String? updatedAt;

  PerubahanBeratModel(
      {this.id,
      this.personalDetailId,
      this.beratSebelumnya,
      this.beratSekarang,
      this.jumlahPengurangan,
      this.createdAt,
      this.updatedAt});

  // kalori = double.parse(json['kalori'].toString());

  PerubahanBeratModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    personalDetailId = json['personal_detail_id'];
    beratSebelumnya = double.parse(json['berat_sebelumnya'].toString());
    beratSekarang = double.parse(json['berat_sekarang'].toString());
    jumlahPengurangan = double.parse(json['jumlah_pengurangan'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
