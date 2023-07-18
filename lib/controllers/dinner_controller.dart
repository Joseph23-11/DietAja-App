import 'dart:async';

import 'package:diet_app/models/food_model.dart';
import 'package:diet_app/services/providers/makanan_provider.dart';
import 'package:diet_app/shared/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DinnerController extends GetxController with StateMixin<List<FoodModel>> {
  final MakananProvider _makananProvider;

  DinnerController(this._makananProvider);
  RxInt heightDinner = 0.obs;
  RxInt dinner = 0.obs;
  RxInt dinnerProtein = 0.obs;
  RxInt dinnerLemak = 0.obs;
  RxInt dinnerKarbo = 0.obs;

  Future getDinner() async {
    try {
      change(null, status: RxStatus.loading());
      var result = await _makananProvider.getDinners();

      heightDinner.value = 75 * result!.length;

      dinner.value = 0;
      dinnerProtein.value = 0;
      dinnerLemak.value = 0;
      dinnerKarbo.value = 0;
      for (var i = 0; i < result.length; i++) {
        dinner.value += result[i].kalori!.ceil();
        dinnerProtein.value += result[i].protein!.ceil();
        dinnerLemak.value += result[i].lemak!.ceil();
        dinnerKarbo.value += result[i].karbohidrat!.ceil();
      }

      change(result, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
      print('error get: ${e.toString()}');
    }
  }

  Future postDinner(int id, double porsi, var context) async {
    try {
      final body = {
        'food_id': id,
        'porsi_makanan': porsi,
      };

      await _makananProvider.postDinners(body);

      await getDinner();

      print('porsi : $porsi');
      Get.toNamed('/main-page');
    } catch (e) {
      print(e.toString());
    }
  }

  Future delDinner(int id, context) async {
    try {
      await _makananProvider.delDinners(id);

      var result = await _makananProvider.getDinners();

      heightDinner.value = 75 * result!.length;

      dinner.value = 0;
      dinnerProtein.value = 0;
      dinnerLemak.value = 0;
      dinnerKarbo.value = 0;
      for (var i = 0; i < result.length; i++) {
        dinner.value += result[i].kalori!.ceil();
        dinnerProtein.value += result[i].protein!.ceil();
        dinnerLemak.value += result[i].lemak!.ceil();
        dinnerKarbo.value += result[i].karbohidrat!.ceil();
      }

      change(result, status: RxStatus.success());

      showCustomSnackbar(
          context, 'Berhasil menghapus Dinner', Colors.greenAccent);
    } catch (e) {
      print('error del: ${e.toString()}');
    }
  }

  Future putDinner(int id, double porsi, var context) async {
    try {
      final body = {
        'porsi_makanan': porsi,
      };

      await _makananProvider.putDinners(body, id);

      showCustomSnackbar(
          context, 'Berhasil mengedit porsi Dinner', Colors.greenAccent);

      await getDinner();

      Get.toNamed('/main-page');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getDinner();
  }
}
