import 'package:diet_app/models/perubahan_berat_model.dart';
import 'package:diet_app/models/prediksi_model.dart';
import 'package:diet_app/services/providers/perubahan_berat_provider.dart';
import 'package:diet_app/shared/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/chart_data.dart';

class PerubahanBeratController extends GetxController
    with StateMixin<List<PerubahanBeratModel>> {
  final PerubahanBeratProvider _perubahanBeratProvider;

  PerubahanBeratController(this._perubahanBeratProvider);

  RxList<ChartData> weightDataList = <ChartData>[].obs;
  RxList<ChartData> regresiList = <ChartData>[].obs;
  RxList<ChartData> regresiList2 = <ChartData>[].obs;
  PrediksiBeratSekarang prediksiBerat = PrediksiBeratSekarang();
  HariTarget hariTarget = HariTarget();

  RxBool isLoading = false.obs;

  RxBool isPrediction = false.obs;

  Future getPrediksi() async {
    try {
      isLoading.value = true;

      var result = await _perubahanBeratProvider.getPrediksi();

      prediksiBerat = result.prediksiBeratSekarang!;
      hariTarget = result.hariTarget!;

      weightDataList.add(ChartData(result.prediksiBeratSekarang!.tanggal,
          result.prediksiBeratSekarang!.berat));

      regresiList2.insert(
        0,
        ChartData(
            result.regressionLine![0].hari, result.regressionLine![0].berat),
      );

      int xy = result.regressionLine![result.regressionLine!.length - 1].berat!
          .ceil();

      regresiList2.insert(
        1,
        ChartData(
          result.regressionLine![result.regressionLine!.length - 1].hari!,
          double.parse(xy.toString()),
        ),
      );

      int indexReg = 0;

      for (var i in result.regressionLine!) {
        regresiList.insert(indexReg, ChartData(i.hari, i.berat));
        indexReg++;
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print('error disini $e');
    }
  }

  Future getPerubahanBerat() async {
    try {
      isLoading.value = true;
      change(null, status: RxStatus.loading());
      var result = await _perubahanBeratProvider.getPerubahanBerat();
      int index = 0;
      for (var i in result!) {
        weightDataList.insert(index, ChartData(i.createdAt, i.beratSekarang));
        index++;
      }

      await getPrediksi();

      change(result, status: RxStatus.success());
      isLoading.value = false;
    } catch (e) {
      change(null, status: RxStatus.error("error disini" + e.toString()));
      isLoading.value = false;
    }
  }

  Future postPerubahanBerat(double berat) async {
    try {
      final body = {
        'berat_sekarang': berat,
      };

      await _perubahanBeratProvider.postPerubahanBerat(body);

      var result = await _perubahanBeratProvider.getPerubahanBerat();

      change(result, status: RxStatus.success());

      Get.back();
    } catch (e) {
      print(e.toString());
    }
  }

  Future delPerubahanBerat(int id, var context) async {
    try {
      await _perubahanBeratProvider.delPerubahanBerat(id);

      var result = await _perubahanBeratProvider.getPerubahanBerat();

      change(result, status: RxStatus.success());

      showCustomSnackbar(
          context, 'Berhasil menghapus Perubahan Berat', Colors.greenAccent);
    } catch (e) {
      print('error del: ${e.toString()}');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getPerubahanBerat();
  }
}
