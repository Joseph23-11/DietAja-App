import 'package:diet_app/models/daily_sport_model.dart';
import 'package:diet_app/services/providers/sport_providers.dart';
import 'package:diet_app/shared/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SportDailyController extends GetxController
    with StateMixin<List<DailySportModel>> {
  final SportProvider _sportProvider;

  SportDailyController(this._sportProvider);
  RxInt heightSport = 0.obs;
  RxInt sport = 0.obs;

  Future getSport() async {
    try {
      change(null, status: RxStatus.loading());
      var result = await _sportProvider.getSport();

      heightSport.value = 75 * result!.length;

      sport.value = 0;
      for (var i = 0; i < result.length; i++) {
        sport.value += result[i].kalori!.ceil();
      }

      change(result, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
      print('error get: ${e.toString()}');
    }
  }

  Future postSport(int id, int valJam, int valMenit) async {
    String jam;
    if (valJam <= 9) {
      jam = '0$valJam';
    } else {
      jam = '$valJam';
    }

    String menit;
    if (valMenit <= 9) {
      menit = '0$valMenit';
    } else {
      menit = '$valMenit';
    }

    String durasi = '$jam:$menit:00';
    print('durasi : $durasi');
    try {
      final body = {
        'sport_id': id,
        'durasi': durasi,
      };

      await _sportProvider.postSport(body);
      await getSport();

      Get.toNamed('/main-page');
    } catch (e) {
      print(e.toString());
    }
  }

  Future delSport(int id, var context) async {
    try {
      await _sportProvider.delSport(id);

      var result = await _sportProvider.getSport();

      heightSport.value = 75 * result!.length;

      sport.value = 0;
      for (var i = 0; i < result.length; i++) {
        sport.value += result[i].kalori!.ceil();
      }

      change(result, status: RxStatus.success());

      showCustomSnackbar(
          context, 'Berhasil menghapus Aktivitas', Colors.greenAccent);
    } catch (e) {
      print('error del: ${e.toString()}');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getSport();
  }
}
