class ResponseResultMakananModel {
  bool? success;
  List<MakananModel>? data;

  ResponseResultMakananModel({this.success, this.data});

  ResponseResultMakananModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <MakananModel>[];
      json['data'].forEach((v) {
        data!.add(MakananModel.fromJson(v));
      });
    }
  }
}

class MakananModel {
  int? id;
  String? namaMakanan;
  double? beratMakanan;
  double? kalori;
  double? protein;
  double? lemak;
  double? karbohidrat;
  String? ukuran;
  String? createdAt;
  String? updatedAt;

  MakananModel(
      {this.id,
      this.namaMakanan,
      this.beratMakanan,
      this.kalori,
      this.protein,
      this.lemak,
      this.karbohidrat,
      this.ukuran,
      this.createdAt,
      this.updatedAt});

  MakananModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaMakanan = json['nama_makanan'];
    beratMakanan = double.parse(json['berat_makanan'].toString());
    kalori = double.parse(json['kalori'].toString());
    protein = double.parse(json['protein'].toString());
    lemak = double.parse(json['lemak'].toString());
    karbohidrat = double.parse(json['karbohidrat'].toString());
    ukuran = json['ukuran'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
