import 'dart:async';

import 'package:diet_app/models/food_model.dart';
import 'package:diet_app/services/providers/makanan_provider.dart';
import 'package:diet_app/shared/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackController extends GetxController with StateMixin<List<FoodModel>> {
  final MakananProvider _makananProvider;

  SnackController(this._makananProvider);
  RxInt heightSnack = 0.obs;
  RxInt snack = 0.obs;
  RxInt snackProtein = 0.obs;
  RxInt snackLemak = 0.obs;
  RxInt snackKarbo = 0.obs;

  Future getSnack() async {
    try {
      change(null, status: RxStatus.loading());
      var result = await _makananProvider.getSnacks();

      heightSnack.value = 75 * result!.length;

      snack.value = 0;
      snackProtein.value = 0;
      snackLemak.value = 0;
      snackKarbo.value = 0;
      for (var i = 0; i < result.length; i++) {
        snack.value += result[i].kalori!.ceil();
        snackProtein.value += result[i].protein!.ceil();
        snackLemak.value += result[i].lemak!.ceil();
        snackKarbo.value += result[i].karbohidrat!.ceil();
      }

      change(result, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
      print('error get: ${e.toString()}');
    }
  }

  Future postSnack(int id, double porsi, var context) async {
    try {
      final body = {
        'food_id': id,
        'porsi_makanan': porsi,
      };

      await _makananProvider.postSnacks(body);

      await getSnack();

      print('porsi : $porsi');
      Get.toNamed('/main-page');
    } catch (e) {
      print(e.toString());
    }
  }

  Future delSnack(int id, var context) async {
    try {
      await _makananProvider.delSnacks(id);

      var result = await _makananProvider.getSnacks();

      heightSnack.value = 75 * result!.length;

      snack.value = 0;
      snackProtein.value = 0;
      snackLemak.value = 0;
      snackKarbo.value = 0;
      for (var i = 0; i < result.length; i++) {
        snack.value += result[i].kalori!.ceil();
        snackProtein.value += result[i].protein!.ceil();
        snackLemak.value += result[i].lemak!.ceil();
        snackKarbo.value += result[i].karbohidrat!.ceil();
      }

      change(result, status: RxStatus.success());

      showCustomSnackbar(
          context, 'Berhasil menghapus Snack', Colors.greenAccent);
    } catch (e) {
      print('error del: ${e.toString()}');
    }
  }

  Future putSnack(int id, double porsi, var context) async {
    try {
      final body = {
        'porsi_makanan': porsi,
      };

      await _makananProvider.putSnacks(body, id);

      showCustomSnackbar(
          context, 'Berhasil mengedit porsi Snack', Colors.greenAccent);

      await getSnack();

      Get.toNamed('/main-page');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getSnack();
  }
}
