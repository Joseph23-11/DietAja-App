import 'dart:async';

import 'package:diet_app/models/food_model.dart';
import 'package:diet_app/services/providers/makanan_provider.dart';
import 'package:diet_app/shared/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BreakfastController extends GetxController
    with StateMixin<List<FoodModel>> {
  final MakananProvider _makananProvider;

  BreakfastController(this._makananProvider);
  RxBool isLoading = false.obs;
  RxInt heightBreakfast = 0.obs;
  RxInt breakfast = 0.obs;
  RxInt breakfastProtein = 0.obs;
  RxInt breakfastLemak = 0.obs;
  RxInt breakfastKarbo = 0.obs;

  Future getBreakfast() async {
    try {
      change(null, status: RxStatus.loading());
      var result = await _makananProvider.getBreakfast();

      heightBreakfast.value = 75 * result!.length;

      breakfast.value = 0;
      breakfastProtein.value = 0;
      breakfastLemak.value = 0;
      breakfastKarbo.value = 0;
      for (var i = 0; i < result.length; i++) {
        breakfast.value += result[i].kalori!.ceil();
        breakfastProtein.value += result[i].protein!.ceil();
        breakfastLemak.value += result[i].lemak!.ceil();
        breakfastKarbo.value += result[i].karbohidrat!.ceil();
      }

      change(result, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
      print('error get: ${e.toString()}');
    }
  }

  Future postBreakfast(int id, double porsi, var context) async {
    try {
      final body = {
        'food_id': id,
        'porsi_makanan': porsi,
      };

      await _makananProvider.postBreakfast(body);

      // Menampilkan notifikasi jika porsi berhasil diubah
      showCustomSnackbar(
          context, 'Berhasil mengedit porsi Breakfast', Colors.greenAccent);

      await getBreakfast();

      print('porsi : $porsi');
      Get.toNamed('/main-page');
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future delBreakfast(int id, var context) async {
    try {
      await _makananProvider.delBreakfast(id);
      isLoading.value = true;

      var result = await _makananProvider.getBreakfast();

      heightBreakfast.value = 75 * result!.length;

      breakfast.value = 0;
      breakfastProtein.value = 0;
      breakfastLemak.value = 0;
      breakfastKarbo.value = 0;
      for (var i = 0; i < result.length; i++) {
        breakfast.value += result[i].kalori!.ceil();
        breakfastProtein.value += result[i].protein!.ceil();
        breakfastLemak.value += result[i].lemak!.ceil();
        breakfastKarbo.value += result[i].karbohidrat!.ceil();
      }

      change(result, status: RxStatus.success());
      isLoading.value = false;

      // Get.snackbar('Success', 'Berhasil menghapus Breakfast');
      showCustomSnackbar(
          context, 'Berhasil menghapus Breakfast', Colors.greenAccent);
    } catch (e) {
      isLoading.value = false;
      print('error del: ${e.toString()}');
    }
  }

  Future putBreakfast(int id, double porsi, var context) async {
    try {
      final body = {
        'porsi_makanan': porsi,
      };

      await _makananProvider.putBreakfast(body, id);

      // Menampilkan notifikasi jika porsi berhasil diubah
      showCustomSnackbar(
          context, 'Berhasil mengedit porsi Breakfast', Colors.greenAccent);

      await getBreakfast();

      Get.toNamed('/main-page');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getBreakfast();
  }
}
