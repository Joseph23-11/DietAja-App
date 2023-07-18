class ResponseResultDailyDietModel {
  bool? success;
  String? message;
  DailyDietModel? data;

  ResponseResultDailyDietModel({this.success, this.message, this.data});

  ResponseResultDailyDietModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? DailyDietModel.fromJson(json['data']) : null;
  }
}

class DailyDietModel {
  List<DailyFood>? breakfasts;
  List<DailyFood>? lunches;
  List<DailyFood>? dinners;
  List<DailyFood>? snacks;
  List<DailySports>? dailySports;
  double? totalKaloriBreakfast;
  double? totalKaloriLunch;
  double? totalKaloriDinner;
  double? totalKaloriSnack;
  double? totalKaloriDailySport;
  double? totalKaloriDaily;

  DailyDietModel(
      {this.breakfasts,
      this.lunches,
      this.dinners,
      this.snacks,
      this.dailySports,
      this.totalKaloriBreakfast,
      this.totalKaloriLunch,
      this.totalKaloriDinner,
      this.totalKaloriSnack,
      this.totalKaloriDailySport,
      this.totalKaloriDaily});

  DailyDietModel.fromJson(Map<String, dynamic> json) {
    if (json['breakfasts'] != null) {
      breakfasts = <DailyFood>[];
      json['breakfasts'].forEach((v) {
        breakfasts!.add(DailyFood.fromJson(v));
      });
    }
    if (json['lunches'] != null) {
      lunches = <DailyFood>[];
      json['lunches'].forEach((v) {
        lunches!.add(DailyFood.fromJson(v));
      });
    }
    if (json['dinners'] != null) {
      dinners = <DailyFood>[];
      json['dinners'].forEach((v) {
        dinners!.add(DailyFood.fromJson(v));
      });
    }
    if (json['snacks'] != null) {
      snacks = <DailyFood>[];
      json['snacks'].forEach((v) {
        snacks!.add(DailyFood.fromJson(v));
      });
    }
    if (json['dailySports'] != null) {
      dailySports = <DailySports>[];
      json['dailySports'].forEach((v) {
        dailySports!.add(DailySports.fromJson(v));
      });
    }
    totalKaloriBreakfast =
        double.parse(json['total_kalori_breakfast'].toString());
    totalKaloriLunch = double.parse(json['total_kalori_lunch'].toString());
    totalKaloriDinner = double.parse(json['total_kalori_dinner'].toString());
    totalKaloriSnack = double.parse(json['total_kalori_snack'].toString());
    totalKaloriDailySport =
        double.parse(json['total_kalori_daily_sport'].toString());
    totalKaloriDaily = double.parse(json['total_kalori_daily'].toString());
  }
}

class DailyFood {
  int? id;
  String? userId;
  String? foodId;
  String? namaMakanan;
  double? porsiMakanan;
  double? kalori;
  double? protein;
  double? lemak;
  double? karbohidrat;
  String? createdAt;
  String? updatedAt;

  DailyFood(
      {this.id,
      this.userId,
      this.foodId,
      this.namaMakanan,
      this.porsiMakanan,
      this.kalori,
      this.protein,
      this.lemak,
      this.karbohidrat,
      this.createdAt,
      this.updatedAt});

  DailyFood.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    foodId = json['food_id'];
    namaMakanan = json['nama_makanan'];
    porsiMakanan = double.parse(json['porsi_makanan'].toString());
    kalori = double.parse(json['kalori'].toString());
    protein = double.parse(json['protein'].toString());
    lemak = double.parse(json['lemak'].toString());
    karbohidrat = double.parse(json['karbohidrat'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class DailySports {
  int? id;
  String? userId;
  String? sportId;
  String? namaOlahraga;
  String? durasi;
  double? kalori;
  String? createdAt;
  String? updatedAt;

  DailySports(
      {this.id,
      this.userId,
      this.sportId,
      this.durasi,
      this.kalori,
      this.createdAt,
      this.updatedAt});

  DailySports.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sportId = json['sport_id'];
    namaOlahraga = json['nama_olahraga'];
    durasi = json['durasi'];
    kalori = double.parse(json['kalori'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
