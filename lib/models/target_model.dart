class ResponseResultTargetModel {
  bool? success;
  TargetModel? data;

  ResponseResultTargetModel({this.success, this.data});

  ResponseResultTargetModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? TargetModel.fromJson(json['data']) : null;
  }
}

class TargetModel {
  int? id;
  int? userId;
  String? levelAktivitas;
  double? targetBeratBadan;
  String? targetDiet;
  double? targetHariDiet;
  double? budgetKaloriHarian;
  double? totalPenguranganBerat;
  String? createdAt;
  String? updatedAt;

  TargetModel(
      {this.id,
      this.userId,
      this.levelAktivitas,
      this.targetBeratBadan,
      this.targetDiet,
      this.targetHariDiet,
      this.budgetKaloriHarian,
      this.totalPenguranganBerat,
      this.createdAt,
      this.updatedAt});

  TargetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = int.parse(json['user_id'].toString());
    levelAktivitas = json['level_aktivitas'];
    targetBeratBadan = double.parse(json['target_berat_badan'].toString());
    targetDiet = json['target_diet'];
    targetHariDiet = double.parse(json['target_hari_diet'].toString());
    budgetKaloriHarian = double.parse(json['budget_kalori_harian'].toString());
    totalPenguranganBerat =
        double.parse(json['total_pengurangan_berat'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
