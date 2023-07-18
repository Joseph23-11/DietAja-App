class ResponseResultFoodModel {
  bool? success;
  String? message;
  List<FoodModel>? data;

  ResponseResultFoodModel({this.success, this.message, this.data});

  ResponseResultFoodModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FoodModel>[];
      json['data'].forEach((v) {
        data!.add(FoodModel.fromJson(v));
      });
    }
  }
}

class FoodModel {
  int? id;
  int? userId;
  int? foodId;
  double? porsiMakanan;
  double? kalori;
  double? protein;
  double? lemak;
  double? karbohidrat;
  String? createdAt;
  String? updatedAt;
  String? namaMakanan;

  FoodModel({
    this.id,
    this.userId,
    this.foodId,
    this.porsiMakanan,
    this.kalori,
    this.protein,
    this.lemak,
    this.karbohidrat,
    this.createdAt,
    this.updatedAt,
    this.namaMakanan,
  });

  FoodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = int.parse(json['user_id'].toString());
    foodId = int.parse(json['food_id'].toString());
    porsiMakanan = double.parse(json['porsi_makanan'].toString());
    kalori = double.parse(json['kalori'].toString());
    protein = double.parse(json['protein'].toString());
    lemak = double.parse(json['lemak'].toString());
    karbohidrat = double.parse(json['karbohidrat'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    namaMakanan = json['nama_makanan'];
  }
}
