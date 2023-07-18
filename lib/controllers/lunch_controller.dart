import 'dart:async';

import 'package:diet_app/models/food_model.dart';
import 'package:diet_app/services/providers/makanan_provider.dart';
import 'package:diet_app/shared/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LunchController extends GetxController with StateMixin<List<FoodModel>> {
  final MakananProvider _makananProvider;

  LunchController(this._makananProvider);
  RxInt heightLunch = 0.obs;
  RxInt lunch = 0.obs;
  RxInt lunchProtein = 0.obs;
  RxInt lunchLemak = 0.obs;
  RxInt lunchKarbo = 0.obs;

  Future getLunch() async {
    try {
      change(null, status: RxStatus.loading());
      var result = await _makananProvider.getLunches();

      heightLunch.value = 75 * result!.length;

      lunch.value = 0;
      lunchProtein.value = 0;
      lunchLemak.value = 0;
      lunchKarbo.value = 0;
      for (var i = 0; i < result.length; i++) {
        lunch.value += result[i].kalori!.ceil();
        lunchProtein.value += result[i].protein!.ceil();
        lunchLemak.value += result[i].lemak!.ceil();
        lunchKarbo.value += result[i].karbohidrat!.ceil();
      }

      change(result, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
      print('error get: ${e.toString()}');
    }
  }

  Future postLunch(int id, double porsi, var context) async {
    try {
      final body = {
        'food_id': id,
        'porsi_makanan': porsi,
      };

      await _makananProvider.postLunches(body);

      // Menampilkan notifikasi jika porsi berhasil diubah
      showCustomSnackbar(
          context, 'Berhasil mengedit porsi Lunch', Colors.greenAccent);

      await getLunch();

      print('porsi : $porsi');
      Get.toNamed('/main-page');
    } catch (e) {
      print(e.toString());
    }
  }

  Future delLunch(int id, var context) async {
    try {
      await _makananProvider.delLunches(id);

      var result = await _makananProvider.getLunches();

      heightLunch.value = 75 * result!.length;

      lunch.value = 0;
      lunchProtein.value = 0;
      lunchLemak.value = 0;
      lunchKarbo.value = 0;
      for (var i = 0; i < result.length; i++) {
        lunch.value += result[i].kalori!.ceil();
        lunchProtein.value += result[i].protein!.ceil();
        lunchLemak.value += result[i].lemak!.ceil();
        lunchKarbo.value += result[i].karbohidrat!.ceil();
      }

      await showCustomSnackbar(
          context, 'Berhasil menghapus Lunch', Colors.greenAccent);

      change(result, status: RxStatus.success());
    } catch (e) {
      print('error del: ${e.toString()}');
    }
  }

  Future putLunch(int id, double porsi, var context) async {
    try {
      final body = {
        'porsi_makanan': porsi,
      };

      await _makananProvider.putLunches(body, id);

      // Menampilkan notifikasi jika porsi berhasil diubah
      showCustomSnackbar(
          context, 'Berhasil mengedit porsi Lunch', Colors.greenAccent);

      await getLunch();

      Get.toNamed('/main-page');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getLunch();
  }
}
